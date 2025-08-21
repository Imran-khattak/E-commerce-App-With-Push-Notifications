import 'package:flutter/material.dart';
import 'package:notifications/constants/image_strings.dart';
import 'package:notifications/datass/repo/auth_repositories.dart';
import 'package:notifications/datass/repo/user_repo.dart';

import 'package:notifications/provider/user_controller.dart';
import 'package:notifications/widgets/popus/loaders.dart';
import 'package:notifications/widgets/popus/popups.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthenticationProvider authenticationProvider =
      AuthenticationProvider();
  final UserRepository userRepository = UserRepository();
  final UserController _userController = UserController();

  bool isPasswordVisible = true;

  bool isRememberme = false;

  void togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleAgreeTerm() {
    isRememberme = !isRememberme;
    notifyListeners();
  }

  // Keys for shared preferences
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';
  static const String _rememberMeKey = 'remember_me';

  // Constructor to load saved credentials if available
  LoginController() {
    _loadSavedCredentials();
  }

  // Load saved credentials from shared preferences
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    isRememberme = prefs.getBool(_rememberMeKey) ?? false;

    if (isRememberme) {
      emailController.text = prefs.getString(_emailKey) ?? '';
      passwordController.text = prefs.getString(_passwordKey) ?? '';
    }

    // delay the notifyListeners so it doesn’t trigger during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Save credentials to shared preferences
  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    if (isRememberme) {
      await prefs.setString(_emailKey, emailController.text.trim());
      await prefs.setString(_passwordKey, passwordController.text.trim());
      await prefs.setBool(_rememberMeKey, true);
    } else {
      // Clear saved credentials if "Remember Me" is unchecked
      await prefs.remove(_emailKey);
      await prefs.remove(_passwordKey);
      await prefs.setBool(_rememberMeKey, false);
    }
  }

  void signInWithEmailandPassword(BuildContext context) async {
    try {
      if (!(formKey.currentState!.validate())) {
        return;
      }

      // Step 3: Start loading animation
      TFullScreenLoader.openLoadingDialog(
        context,
        "Logging in you...",
        TImages.docerAnimation,
      );

      // Step 4: Login User with email and password
      await authenticationProvider.loginWithEmailandPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Step 5: Save credentials if "Remember Me" is checked
      await _saveCredentials();

      // Step 6: Close loading dialog
      TFullScreenLoader.stopLoading();

      // Step 7: Redirect to appropriate screen
      authenticationProvider.screenRedirect();
    } catch (e) {
      // Always ensure the loader is stopped
      TFullScreenLoader.stopLoading();

      authenticationProvider.screenRedirect();

      // Display the error to the user
      TLoaders.errorSnackBar(
        context: context,
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }

  // Sign In With Google signIn...

  Future<void> googleSignIn(BuildContext context) async {
    try {
      // Step 3: Start loading animation
      TFullScreenLoader.openLoadingDialog(
        context,
        "Logging in you...",
        TImages.docerAnimation,
      );

      print("Before Google Auth ");
      // Step 4: Login User with email and password
      final userCredential = await authenticationProvider.signInWithGoogle();
      print("After Google Auth ");
      await _userController.savedUserRecord(context, userCredential);
      print("After Saving Record ");

      // Step 6: Close loading dialog
      TFullScreenLoader.stopLoading();

      // Step 7: Redirect to appropriate screen
      authenticationProvider.screenRedirect();
    } catch (e) {
      // Always ensure the loader is stopped
      TFullScreenLoader.stopLoading();

      authenticationProvider.screenRedirect();

      // Display the error to the user
      TLoaders.errorSnackBar(
        context: context,
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
