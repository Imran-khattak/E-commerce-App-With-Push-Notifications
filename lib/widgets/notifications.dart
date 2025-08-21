import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationBell extends StatelessWidget {
  final int notificationCount;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color badgeColor;

  const NotificationBell({
    Key? key,
    this.notificationCount = 0,
    this.onTap,
    this.backgroundColor = Colors.blue, // Replace with Utils.maincolor
    this.badgeColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15,
              spreadRadius: 1,
              offset: Offset(4.0, 4.0),
            ),
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15,
              spreadRadius: 1,
              offset: Offset(-4.0, -4.0),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none, // Important: Allows overflow
          children: [
            const Icon(CupertinoIcons.bell_fill, color: Colors.white, size: 24),
            if (notificationCount > 0)
              Positioned(
                right: -8,
                top: -8,
                child: Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: badgeColor,
                  ),
                  child: Center(
                    child: Text(
                      notificationCount > 99
                          ? '99+'
                          : notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
