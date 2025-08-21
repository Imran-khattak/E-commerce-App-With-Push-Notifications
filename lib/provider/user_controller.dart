import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notifications/constants/image_strings.dart';
import 'package:notifications/datass/repo/auth_repositories.dart';
import 'package:notifications/datass/repo/user_repo.dart';
import 'package:notifications/datass/services/notifications.dart';
import 'package:notifications/model/user_model.dart';
import 'package:notifications/views/login_screen.dart';
import 'package:notifications/widgets/popus/loaders.dart';
import 'package:notifications/widgets/popus/popups.dart';

class UserController with ChangeNotifier {
  final NotificationsServices _notificationService = NotificationsServices();

  final AuthenticationProvider _auth = AuthenticationProvider();
  final UserRepository userRepo = UserRepository();
  UserModel _user = UserModel.empty();
  bool _isLoading = false;

  UserModel get user => _user;
  bool get isLoading => _isLoading;

  // Constructor to initialize and fetch user data
  UserController() {
    fetchUserRecord();
  }

  Future<void> savedUserRecord(
    BuildContext context,
    UserCredential? userCredential,
  ) async {
    try {
      if (userCredential != null) {
        final uid = userCredential.user!.uid;

        // Check if user already exists in Firestore
        final doc = await userRepo.db.collection("Users").doc(uid).get();

        if (!doc.exists) {
          // // Optional: Get device token
          await _notificationService.requestNotificationPermission();
          String? deviceToken = await _notificationService.getDeviceToken();

          final newUser = UserModel(
            id: uid,
            fullName: userCredential.user!.displayName ?? '',
            deviceToken: deviceToken ?? '',
            email: userCredential.user!.email ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
          );

          // Save new user
          await userRepo.saveUser(newUser);
        }

        // Refresh local user state
        await fetchUserRecord();
        notifyListeners();
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        context: context,
        title: "Data not saved",
        message:
            "Something went wrong while saving your information. You can re-save your data in your Profile.",
      );
    }
  }

  //**** ------ Fetch User Record form FireStore ------****/

  Future<void> fetchUserRecord() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Properly await the Future
      final data = await userRepo.fetchUser();
      _user = data;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      // Error handling
    }
  }

  // Method to update device token when it changes
  Future<void> updateDeviceToken() async {
    try {
      String? newToken = await _notificationService.getDeviceToken();
      if (newToken != null && newToken != _user.deviceToken) {
        // Update user model
        _user = _user.copyWith(deviceToken: newToken);

        // Update in Firebase
        await userRepo.updateSingleField({'DeviceToken': newToken});

        notifyListeners();
      }
    } catch (e) {
      print('Error updating device token: $e');
    }
  }

  //***---- Delete User Account -----***/

  void deleteAccount(BuildContext context) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        context,
        "Processing...",
        TImages.docerAnimation,
      );
      final provider = _auth.authUser!.providerData
          .map((e) => e.providerId)
          .first;

      if (provider.isNotEmpty) {
        // if user from Google sign in...
        if (provider == "google.com") {
          await _auth.signInWithGoogle();
          await _auth.deleteUserAccount();
          TFullScreenLoader.stopLoading();
          // After successful deletion, show a nice goodbye message
          TLoaders.successSnackBar(
            context: context,
            title: "Account Deleted",
            message:
                "Your account has been successfully deleted. We're sad to see you go! You're welcome back anytime.",
          );
          // // Use the provided context
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        } else if (provider == "password") {
          TFullScreenLoader.stopLoading();

          // // Use the provided context
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        context: context,
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }

  void signOut(BuildContext context) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        context,
        "Processing...",
        TImages.docerAnimation,
      );
      final authRepo = AuthenticationProvider();
      await authRepo.logout();
      // // Use the provided context
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        context: context,
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }
}
