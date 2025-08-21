import 'package:flutter/material.dart';
import 'package:notifications/constants/theme.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'Order Confirmed',
      message:
          'Your order for Black T-Shirt has been confirmed and will be delivered soon.',
      time: '2 min ago',
      isRead: false,
      type: NotificationType.order,
      icon: Icons.check_circle,
    ),
    NotificationItem(
      id: '2',
      title: 'New Product Alert',
      message:
          'Check out our latest collection of premium jeans now available.',
      time: '1 hour ago',
      isRead: false,
      type: NotificationType.product,
      icon: Icons.new_releases,
    ),
    NotificationItem(
      id: '3',
      title: 'Payment Successful',
      message: 'Payment of \$129.0 has been processed successfully.',
      time: '3 hours ago',
      isRead: true,
      type: NotificationType.payment,
      icon: Icons.payment,
    ),
    NotificationItem(
      id: '4',
      title: 'Flash Sale Started',
      message: 'Get up to 50% off on selected items. Limited time offer!',
      time: '1 day ago',
      isRead: true,
      type: NotificationType.promotion,
      icon: Icons.local_fire_department,
    ),
    NotificationItem(
      id: '5',
      title: 'Order Shipped',
      message: 'Your order #12345 has been shipped and is on its way.',
      time: '2 days ago',
      isRead: true,
      type: NotificationType.order,
      icon: Icons.local_shipping,
    ),
    NotificationItem(
      id: '6',
      title: 'Welcome to UltraNet',
      message: 'Thanks for joining! Explore our premium collection.',
      time: '1 week ago',
      isRead: true,
      type: NotificationType.general,
      icon: Icons.celebration,
    ),
  ];

  void markAsRead(String id) {
    setState(() {
      final index = notifications.indexWhere(
        (notification) => notification.id == id,
      );
      if (index != -1) {
        notifications[index].isRead = true;
      }
    });
  }

  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.maincolor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D3748),
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
            if (unreadCount > 0)
              Text(
                '$unreadCount unread',
                style: const TextStyle(
                  color: Color(0xFF4FD1C7),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: markAllAsRead,
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
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
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
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notification.isRead
            ? const Color(0xFF232a2f).withValues(alpha: 0.6)
            : const Color(0xFF232a2f),
        borderRadius: BorderRadius.circular(16),
        border: notification.isRead
            ? null
            : Border.all(
                color: const Color(0xFF4FD1C7).withOpacity(0.3),
                width: 1,
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (!notification.isRead) {
              markAsRead(notification.id);
            }
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
                    color: _getIconColor(notification.type).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    notification.icon,
                    color: _getIconColor(notification.type),
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
                                color: notification.isRead
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: notification.isRead
                                    ? FontWeight.w500
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
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
                        notification.message,
                        style: TextStyle(
                          color: notification.isRead
                              ? Colors.white.withOpacity(0.5)
                              : Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notification.time,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
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
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return const Color(0xFF4FD1C7);
      case NotificationType.payment:
        return const Color(0xFF68D391);
      case NotificationType.product:
        return const Color(0xFF9F7AEA);
      case NotificationType.promotion:
        return const Color(0xFFF6AD55);
      case NotificationType.general:
        return const Color(0xFF63B3ED);
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  bool isRead;
  final NotificationType type;
  final IconData icon;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.type,
    required this.icon,
  });
}

enum NotificationType { order, payment, product, promotion, general }
