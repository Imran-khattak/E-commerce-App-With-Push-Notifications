import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notifications/datass/repo/auth_repositories.dart';
import 'package:notifications/datass/repo/user_repo.dart';
import 'package:notifications/datass/services/notifications.dart';
import 'package:notifications/model/user_model.dart';
import 'package:notifications/views/home_screeen.dart';
import 'package:notifications/widgets/popus/loaders.dart';
import 'package:notifications/widgets/popus/popups.dart';

class SignupController with ChangeNotifier {
  final NotificationsServices service = NotificationsServices();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  bool agreeToTerms = false;

  final UserRepository userRepository = UserRepository();
  final AuthenticationProvider authenticationProvider =
      AuthenticationProvider();

  void togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  // FIXED: Method name typo
  void toggleConfirmPassword() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  void toggleAgreeTerm() {
    agreeToTerms = !agreeToTerms;
    notifyListeners();
  }

  void signup(BuildContext context) async {
    try {
      // Step 1: Form validation
      if (!(formKey.currentState!.validate())) {
        return;
      }

      // Step 2: Privacy Policy check
      if (!agreeToTerms) {
        TLoaders.warningSnackBar(
          context: context,
          title: "Accept Privacy Policy",
          message:
              "In order to create account, you must have to read and accept the Privacy Policy & Term of use",
        );
        return;
      }
      // Step 3: Request notification permissions and get device token
      await service.requestNotificationPermission();
      String? deviceToken = await service.getDeviceToken();

      // Step 5: Register User with email and password
      final UserCredential userCredential = await authenticationProvider
          .registerWithEmailandPassword(
            emailController.text.trim(),
            passwordController.text.trim(),
          );

      // Step 6: Save user data in Firebase Database
      final newUser = UserModel(
        id: userCredential.user!.uid,
        fullName: nameController.text.trim(),
        deviceToken: deviceToken ?? '', // Store the device token
        email: emailController.text.trim(),

        profilePicture: '',
      );
      await userRepository.saveUser(newUser);

      // Step 7: Stop loading animation after processing is complete
      TFullScreenLoader.stopLoading();

      // Step 8: Show success message
      TLoaders.successSnackBar(
        context: context,
        title: "Congratulations",
        message: "Your account has been created!",
      );

      // Step 9: Clear all form fields after successful signup
      clearAllFields();

      // Step 10: Navigate to verification page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreeen()),
      );
    } catch (e) {
      print("Error during signup: $e");
      // This is a safeguard in case the inner try-catch missed stopping the loader
      TFullScreenLoader.stopLoading();
      Future.microtask(() => Navigator.pop(context));
      TLoaders.errorSnackBar(
        context: context,
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }

  // Method to clear all form fields
  void clearAllFields() {
    nameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();

    isConfirmPasswordVisible = true;
    isPasswordVisible = true;
    agreeToTerms = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
