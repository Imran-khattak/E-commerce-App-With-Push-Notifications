import 'package:flutter/material.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/widgets/colors.dart';
import 'package:notifications/widgets/popus/animations_loader.dart';

// Create a global navigator key to use for dialogs
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// A utility class for managing a full-screen loading dialog.
class TFullScreenLoader {
  // Track loading state
  static bool _isLoading = false;

  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  ///   - context: The BuildContext for the dialog
  ///   - text: The text to be displayed in the loading dialog.
  ///   - animation: The Lottie animation to be shown.
  static void openLoadingDialog(
    BuildContext context,
    String text,
    String animation,
  ) {
    if (_isLoading) return; // Prevent multiple dialogs

    _isLoading = true;
    showDialog(
      context: context,
      barrierDismissible:
          false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: Utils.maincolor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250), // Adjust the spacing as needed
              TAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static void stopLoading() {
    if (_isLoading) {
      _isLoading = false;
      // Use navigatorKey to close the dialog
      if (navigatorKey.currentContext != null) {
        Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop();
      }
    }
  }
}
