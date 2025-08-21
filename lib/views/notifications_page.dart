import 'package:flutter/material.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/model/nofications_model.dart';
import 'package:notifications/provider/notifications_controller.dart';
import 'package:notifications/views/notifications_details_page.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: Utils.maincolor,
          appBar: AppBar(
            backgroundColor: Utils.maincolor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (controller.unreadCount > 0)
                  Text(
                    '${controller.unreadCount} unread',
                    style: const TextStyle(
                      color: Color(0xFF4FD1C7),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
            ),
            actions: [
              if (controller.unreadCount > 0)
                TextButton(
                  onPressed: () {
                    controller.markAllAsRead();
                  },
                  child: const Text(
                    'Mark all read',
                    style: TextStyle(
                      color: Color(0xFF4FD1C7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          body: controller.notifications.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return _buildNotificationCard(notification);
                  },
                ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationsModel notification) {
    return Consumer<NotificationsController>(
      builder: (context, controller, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: notification.isSeen
                ? const Color(0xFF232a2f).withValues(alpha: 0.6)
                : const Color(0xFF232a2f),
            borderRadius: BorderRadius.circular(16),
            border: notification.isSeen
                ? null
                : Border.all(
                    color: const Color(0xFF4FD1C7).withValues(alpha: 0.3),
                    width: 1,
                  ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                if (!notification.isSeen) {
                  controller.markAsSeen(notification.id);
                  // Navigate to detail page
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationDetailPage(notification: notification),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notification Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFF4FD1C7).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Color(0xFF4FD1C7),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Notification Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notification.title,
                                  style: TextStyle(
                                    color: notification.isSeen
                                        ? Colors.white.withValues(alpha: 0.7)
                                        : Colors.white,
                                    fontSize: 16,
                                    fontWeight: notification.isSeen
                                        ? FontWeight.w500
                                        : FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (!notification.isSeen)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4FD1C7),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            notification.body,
                            style: TextStyle(
                              color: notification.isSeen
                                  ? Colors.white.withValues(alpha: 0.5)
                                  : Colors.white.withValues(alpha: 0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            notification.date,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.4),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  bool isRead;

  final IconData icon;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,

    required this.icon,
  });
}
