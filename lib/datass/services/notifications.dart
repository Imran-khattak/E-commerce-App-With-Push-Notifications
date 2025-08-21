import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications/viewss/notfications_screen.dart';

class NotificationsServices {
  static final NotificationsServices _instance =
      NotificationsServices._internal();
  factory NotificationsServices() => _instance;
  NotificationsServices._internal();

  // Firebase Messages instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Notification channel configuration
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  // Request notification permissions
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      sound: true,
      provisional: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("Permission granted");
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("Permission provisional");
      }
    } else {
      if (kDebugMode) {
        print("Permission Denied");
      }
    }
  }

  // Get device token
  Future<String?> getDeviceToken() async {
    try {
      final token = await _messaging.getToken();
      if (kDebugMode) {
        print("Device Token: $token");
      }
      return token;
    } catch (e) {
      if (kDebugMode) {
        print("Error getting device token: $e");
      }
      return null;
    }
  }

  // Listen to token refresh and update in database
  void setupTokenRefreshListener(Function(String) onTokenRefresh) {
    _messaging.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        print("Token refreshed: $newToken");
      }
      onTokenRefresh(newToken);
    });
  }

  // Initialize local notifications (unified method)
  Future<void> _initializeLocalNotifications({
    BuildContext? context,
    RemoteMessage? message,
  }) async {
    const androidInitialized = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosInitialized = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitialized,
      iOS: iosInitialized,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        if (context != null) {
          handleNotificationTap(context, message!);
        }
      },
    );

    // Create notification channel for Android
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    // _isInitialized = true;
  }

  // Unified method to show notifications
  Future<void> showNotification(RemoteMessage message) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.message,
      fullScreenIntent: true,
      when: null, // Use current time
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    const iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // Unique ID
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      notificationDetails,
      payload: message.data.toString(),
    );
  }

  // Initialize all notification services
  Future<void> initNotifications(BuildContext context) async {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      print('Foreground message: ${message.notification?.title ?? 'No Title'}');
      print('Message body: ${message.notification?.body ?? 'No Body'}');
      _initializeLocalNotifications(context: context, message: message);
      showNotification(message);
    });

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        print('Message clicked! ${message.notification?.title}');
      }
      handleNotificationTap(context, message);
    });

    // Handle notification tap when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        if (kDebugMode) {
          print(
            'App launched from notification: ${message.notification?.title}',
          );
        }
        handleNotificationTap(context, message);
      }
    });
  }

  // Static method for background message handling
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('Handling background message: ${message.messageId}');
    }

    final instance = NotificationsServices();
    await instance._initializeLocalNotifications();
    await instance.showNotification(message);
  }

  // Handle notification tap with RemoteMessage
  void handleNotificationTap(BuildContext context, RemoteMessage message) {
    if (kDebugMode) {
      print('Notification tapped: ${message.notification?.title}');
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotficationsScreen(message: message),
      ),
    );
  }
}
