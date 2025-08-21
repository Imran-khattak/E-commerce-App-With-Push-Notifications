import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notifications/datass/repo/auth_repositories.dart';
import 'package:notifications/datass/services/notifications.dart';
import 'package:notifications/firebase_options.dart';
import 'package:notifications/provider/cart_animation_provider.dart';
import 'package:notifications/provider/cart_provider.dart';
import 'package:notifications/provider/login_controller.dart';
import 'package:notifications/provider/notifications_controller.dart';
import 'package:notifications/provider/product_provider.dart';
import 'package:notifications/provider/signup_controller.dart';
import 'package:notifications/provider/user_controller.dart';
import 'package:notifications/splash_screen.dart';

import 'package:provider/provider.dart';

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NotificationsServices.handleBackgroundMessage(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    // Create authentication provider instance to pass its navigatorKey
    final authProvider = AuthenticationProvider();
    return MultiProvider(
      providers: [
        // Authentication provider with initialization
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartAnimationProvider()),
        ChangeNotifierProvider(create: (_) => SignupController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => NotificationsController()),
      ],
      child: MaterialApp(
        navigatorKey: authProvider
            .navigatorKey, // Set navigatorKey for context-less navigation
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
