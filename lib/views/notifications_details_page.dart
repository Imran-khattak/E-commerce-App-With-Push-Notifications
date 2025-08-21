import 'package:flutter/material.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/model/nofications_model.dart';
import 'package:notifications/provider/notifications_controller.dart';
import 'package:notifications/widgets/popus/popups.dart';
import 'package:provider/provider.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationsModel notification;

  const NotificationDetailPage({Key? key, required this.notification})
    : super(key: key);

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
            title: const Text(
              'Notification Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                color: const Color(0xFF232a2f),
                onSelected: (value) =>
                    _handleMenuAction(context, controller, value),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'mark_read',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mark_email_read,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          notification.isSeen
                              ? 'Mark as Unread'
                              : 'Mark as Read',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red, size: 20),
                        SizedBox(width: 12),
                        Text(
                          'Delete Notification',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'share',
                    child: Row(
                      children: [
                        Icon(Icons.share, color: Colors.white, size: 20),
                        SizedBox(width: 12),
                        Text('Share', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232a2f),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF4FD1C7,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.notifications_active,
                            color: Color(0xFF4FD1C7),
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Title
                        Text(
                          notification.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Time and Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white.withValues(alpha: 0.6),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              notification.date,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: notification.isSeen
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : const Color(
                                        0xFF4FD1C7,
                                      ).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                notification.isSeen ? 'Read' : 'New',
                                style: TextStyle(
                                  color: notification.isSeen
                                      ? Colors.white.withValues(alpha: 0.7)
                                      : const Color(0xFF4FD1C7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Message Content
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232a2f),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Message',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          notification.body,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Extended content based on notification content
                        if (_getExtendedContent(notification.body).isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: Colors.white.withValues(alpha: 0.1),
                                height: 32,
                              ),
                              Text(
                                _getExtendedContent(notification.body),
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Notification Details
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232a2f),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow('Notification ID', notification.id),
                        _buildDetailRow('Received', notification.date),
                        _buildDetailRow(
                          'Status',
                          notification.isSeen ? 'Read' : 'Unread',
                        ),
                        _buildDetailRow(
                          'Priority',
                          _getPriorityFromContent(notification.body),
                        ),
                        _buildDetailRow(
                          'Category',
                          _getCategoryFromContent(notification.body),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  _buildActionButtons(context, controller),

                  const SizedBox(height: 20),

                  // Mark as read/unread button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (notification.isSeen) {
                          controller.markAsSeen(notification.id);
                        } else {
                          controller.markAsSeen(notification.id);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Marked as read'),
                            backgroundColor: const Color(0xFF4FD1C7),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: Icon(
                        notification.isSeen
                            ? Icons.mark_email_unread
                            : Icons.mark_email_read,
                        size: 18,
                      ),
                      label: Text('Mark as Read'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    NotificationsController controller,
  ) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _handleReply(context),
            icon: const Icon(Icons.reply, size: 18),
            label: const Text('Reply'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Utils.pacificblue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _handleDelete(context, controller),
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text('Delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withValues(alpha: 0.1),
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.red.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getExtendedContent(String body) {
    // Add extended content based on the notification body
    if (body.toLowerCase().contains('order')) {
      return 'We\'ll keep you updated on your order status. You can track your package and get real-time updates on delivery progress.';
    } else if (body.toLowerCase().contains('payment')) {
      return 'Your payment has been processed securely. A receipt has been sent to your registered email address for your records.';
    } else if (body.toLowerCase().contains('welcome') ||
        body.toLowerCase().contains('account')) {
      return 'Thank you for joining our community. Explore all the features and benefits available to you as a member.';
    } else if (body.toLowerCase().contains('update') ||
        body.toLowerCase().contains('new')) {
      return 'Stay updated with the latest features and improvements. We continuously work to enhance your experience.';
    }
    return '';
  }

  String _getPriorityFromContent(String body) {
    if (body.toLowerCase().contains('urgent') ||
        body.toLowerCase().contains('important')) {
      return 'High';
    } else if (body.toLowerCase().contains('payment') ||
        body.toLowerCase().contains('order')) {
      return 'Medium';
    }
    return 'Normal';
  }

  String _getCategoryFromContent(String body) {
    if (body.toLowerCase().contains('order')) {
      return 'Orders';
    } else if (body.toLowerCase().contains('payment')) {
      return 'Payments';
    } else if (body.toLowerCase().contains('account') ||
        body.toLowerCase().contains('profile')) {
      return 'Account';
    } else if (body.toLowerCase().contains('update') ||
        body.toLowerCase().contains('new')) {
      return 'Updates';
    }
    return 'General';
  }

  void _handleMenuAction(
    BuildContext context,
    NotificationsController controller,
    String action,
  ) {
    switch (action) {
      case 'mark_read':
        if (notification.isSeen) {
          controller.markAsSeen(notification.id);
        } else {
          controller.markAsSeen(notification.id);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Marked as read'),
            backgroundColor: const Color(0xFF4FD1C7),
            behavior: SnackBarBehavior.floating,
          ),
        );
        break;
      case 'delete':
        _handleDelete(context, controller);
        break;
      case 'share':
        _handleShare(context);
        break;
    }
  }

  void _handleReply(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening reply screen...'),
        backgroundColor: Color(0xFF4FD1C7),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleDelete(BuildContext context, NotificationsController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF232a2f),
          title: const Text(
            'Delete Notification',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to delete this notification? This action cannot be undone.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.deleteNotification(notification.id);
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to notifications list
                TLoaders.errorSnackBar(
                  context: context,
                  title: 'Notifications Update',
                  message: 'Notifications Deleted',
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _handleShare(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening share options...'),
        backgroundColor: Color(0xFF4FD1C7),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
