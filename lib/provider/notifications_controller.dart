// User-Aware Notifications Controller
import 'package:flutter/material.dart';
import 'package:notifications/datass/repo/notifications_repo.dart';
import 'package:notifications/model/nofications_model.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsController with ChangeNotifier {
  bool _isLoading = false;
  bool _isMarkingAllRead = false;
  List<NotificationsModel> _notifications = [];
  int _unreadCount = 0;

  bool get isLoading => _isLoading;
  bool get isMarkingAllRead => _isMarkingAllRead;
  List<NotificationsModel> get notifications => _notifications;
  int get unreadCount => _unreadCount;

  // Get current user ID
  String? get _currentUserId {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  NotificationsController() {
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    if (_currentUserId != null) {
      await getNotifications();
      await _updateUnreadCount();
    }
  }

  // Create order notification with current user ID
  Future<void> createOrderNotification({
    required String productName,
    required double productPrice,
    required int itemCount,
    required double totalAmount,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      if (_currentUserId == null) {
        throw Exception("User not authenticated");
      }

      final String notificationId = const Uuid().v4();
      final String catchyTitle = NotificationTitleGenerator.getRandomTitle();
      final String description = NotificationTitleGenerator.generateDescription(
        productName: productName,
        productPrice: productPrice,
        itemCount: itemCount,
        totalAmount: totalAmount,
      );

      final notification = NotificationsModel(
        id: notificationId,
        userId: _currentUserId!, // Add user ID
        title: catchyTitle,
        body: description,
        productName: productName,
        productPrice: productPrice,
        itemCount: itemCount,
        totalAmount: totalAmount,
        orderStatus: 'processing',
        isSeen: false,
        createdDate: DateTime.now(),
        additionalData: additionalData,
      );

      await saveNotifications(notification);
      await _updateUnreadCount();
    } catch (e) {
      throw Exception("Failed to create order notification: ${e.toString()}");
    }
  }

  Future<void> saveNotifications(NotificationsModel notification) async {
    try {
      if (_currentUserId == null) {
        throw Exception("User not authenticated");
      }

      final notRepo = NotificationsRepo();
      await notRepo.saveNotifications(notification);

      // Add to local list if not already present
      if (!_notifications.any((n) => n.id == notification.id)) {
        _notifications.insert(0, notification);
      }

      notifyListeners();
    } catch (e) {
      throw Exception("Failed to save notification: ${e.toString()}");
    }
  }

  Future<void> getNotifications() async {
    try {
      if (_currentUserId == null) {
        throw Exception("User not authenticated");
      }

      _isLoading = true;
      notifyListeners();

      final notRepo = NotificationsRepo();
      final data = await notRepo.fetchUserNotifications(_currentUserId!);
      _notifications = data;

      await _updateUnreadCount();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception("Failed to fetch notifications: ${e.toString()}");
    }
  }

  Future<void> markAsSeen(String notificationId) async {
    try {
      if (_currentUserId == null) {
        throw Exception("User not authenticated");
      }

      final notRepo = NotificationsRepo();
      await notRepo.markAsSeen(notificationId, _currentUserId!);

      // Update local list
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = NotificationsModel(
          id: _notifications[index].id,
          userId: _notifications[index].userId,
          title: _notifications[index].title,
          body: _notifications[index].body,
          productName: _notifications[index].productName,
          productPrice: _notifications[index].productPrice,
          itemCount: _notifications[index].itemCount,
          totalAmount: _notifications[index].totalAmount,
          orderStatus: _notifications[index].orderStatus,
          isSeen: true,
          createdDate: _notifications[index].createdDate,
          additionalData: _notifications[index].additionalData,
        );
      }

      await _updateUnreadCount();
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to mark as seen: ${e.toString()}");
    }
  }

  // Mark all notifications as read for current user
  Future<void> markAllAsRead() async {
    try {
      if (_currentUserId == null) {
        throw Exception("User not authenticated");
      }

      _isMarkingAllRead = true;
      notifyListeners();

      final notRepo = NotificationsRepo();

      // Get all unread notification IDs for current user
      final unreadNotificationIds = _notifications
          .where((notification) => !notification.isSeen)
          .map((notification) => notification.id)
          .toList();

      if (unreadNotificationIds.isNotEmpty) {
        // Mark all as read in Firestore for current user
        await notRepo.markAllAsRead(unreadNotificationIds, _currentUserId!);

        // Update local list
        _notifications = _notifications.map((notification) {
          if (!notification.isSeen) {
            return NotificationsModel(
              id: notification.id,
              userId: notification.userId,
              title: notification.title,
              body: notification.body,
              productName: notification.productName,
              productPrice: notification.productPrice,
              itemCount: notification.itemCount,
              totalAmount: notification.totalAmount,
              orderStatus: notification.orderStatus,
              isSeen: true,
              createdDate: notification.createdDate,
              additionalData: notification.additionalData,
            );
          }
          return notification;
        }).toList();

        // Update unread count
        _unreadCount = 0;
      }

      _isMarkingAllRead = false;
      notifyListeners();
    } catch (e) {
      _isMarkingAllRead = false;
      notifyListeners();
      throw Exception("Failed to mark all as read: ${e.toString()}");
    }
  }

  // Delete notification for current user
  Future<void> deleteNotification(String notificationId) async {
    try {
      if (_currentUserId == null) {
        throw Exception("User not authenticated");
      }

      final notRepo = NotificationsRepo();
      await notRepo.deleteUserNotification(notificationId, _currentUserId!);

      // Remove from local list
      _notifications.removeWhere(
        (notification) => notification.id == notificationId,
      );

      await _updateUnreadCount();
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to delete notification: ${e.toString()}");
    }
  }

  Future<void> _updateUnreadCount() async {
    try {
      if (_currentUserId == null) {
        _unreadCount = 0;
        return;
      }

      final notRepo = NotificationsRepo();
      _unreadCount = await notRepo.getUserUnreadCount(_currentUserId!);
    } catch (e) {
      _unreadCount = 0;
    }
  }

  @override
  void dispose() {
    // Cancel any active listeners here if implemented
    super.dispose();
  }
}
