import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notifications/widgets/colors.dart';

class TLoaders {
  // Method to hide current SnackBar
  static hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  // Custom toast message
  static customToast({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: TColors.darkerGrey.withValues(alpha: 0.9),
          ),
          child: Center(
            child: Text(message, style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ),
    );
  }

  // Success message
  static successSnackBar({
    required BuildContext context,
    required String title,
    String message = '',
    int duration = 3,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.check, color: TColors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: TColors.white,
                    ),
                  ),
                  if (message.isNotEmpty)
                    Text(message, style: const TextStyle(color: TColors.white)),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1ABC9C),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  // Warning message
  static warningSnackBar({
    required BuildContext context,
    required String title,
    String message = '',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.warning_2, color: TColors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: TColors.white,
                    ),
                  ),
                  if (message.isNotEmpty)
                    Text(message, style: const TextStyle(color: TColors.white)),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  // Error message
  static errorSnackBar({
    required BuildContext context,
    required String title,
    String message = '',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.warning_2, color: TColors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: TColors.white,
                    ),
                  ),
                  if (message.isNotEmpty)
                    Text(message, style: const TextStyle(color: TColors.white)),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
      ),
    );
  }
}
