import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notifications/widgets/helper_function.dart';

class NotificationsModel {
  final String id;
  final String title;
  final String body;
  final String userId; // Added user ID field
  final String productName;
  final double productPrice;
  final int itemCount;
  final double totalAmount;
  final String orderStatus;
  final bool isSeen;
  final DateTime createdDate;
  final Map<String, dynamic>? additionalData;

  NotificationsModel({
    required this.userId, // Required user ID
    required this.id,
    required this.title,
    required this.body,
    required this.productName,
    required this.productPrice,
    required this.itemCount,
    required this.totalAmount,
    this.orderStatus = 'processing',
    this.isSeen = false,
    required this.createdDate,
    this.additionalData,
  });

  // Format date for display
  String get date {
    final now = DateTime.now();
    final difference = now.difference(createdDate);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${createdDate.day}/${createdDate.month}/${createdDate.year}';
    }
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId, // Include user ID in Firestore document
      'title': title,
      'body': body,
      'productName': productName,
      'productPrice': productPrice,
      'itemCount': itemCount,
      'totalAmount': totalAmount,
      'orderStatus': orderStatus,
      'isSeen': isSeen,
      'createdDate': Timestamp.fromDate(createdDate),
      'additionalData': additionalData ?? {},
    };
  }

  // Create from Firestore document
  factory NotificationsModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NotificationsModel(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '', // Handle user ID from Firestore
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      productName: data['productName'] ?? '',
      productPrice: (data['productPrice'] ?? 0.0).toDouble(),
      itemCount: data['itemCount'] ?? 0,
      totalAmount: (data['totalAmount'] ?? 0.0).toDouble(),
      orderStatus: data['orderStatus'] ?? 'processing',
      isSeen: data['isSeen'] ?? false,
      createdDate: (data['createdDate'] as Timestamp).toDate(),
      additionalData: data['additionalData'],
    );
  }
}

// Notification Title Generator
class NotificationTitleGenerator {
  static final List<String> _catchyTitles = [
    "🎉 Your order is on its way!",
    "✨ Order confirmed & processing!",
    "🚀 Your purchase is being prepared!",
    "💫 Order successfully placed!",
    "🎊 Thank you for your order!",
    "⚡ Order processing started!",
    "🌟 Your items are being packed!",
    "🎁 Order confirmation received!",
    "🔥 Your order is in the works!",
    "💎 Purchase confirmed successfully!",
  ];

  static final List<String> _descriptionTemplates = [
    "Your order containing {productName} (\${productPrice}) has been successfully processed! We're preparing your {itemCount} item(s) for shipment.",
    "Great news! Your order for {productName} worth \${productPrice} is now being prepared. Total: \${totalAmount}",
    "Order confirmed! {productName} (\${productPrice}) is being packed with care. Expected delivery soon!",
    "Thank you for your purchase! Your {itemCount} items including {productName} are being processed. Total: \${totalAmount}",
    "Your order is confirmed! {productName} worth \${productPrice} is now in our fulfillment center.",
    "Exciting news! Your order containing {productName} has been received and is being prepared for delivery.",
    "Order processing started! {productName} (\${productPrice}) and {itemCount} other items are being handled.",
    "Purchase successful! Your {productName} order worth \${totalAmount} is now in progress.",
  ];

  static String getRandomTitle() {
    _catchyTitles.shuffle();
    return _catchyTitles.first;
  }

  static String generateDescription({
    required String productName,
    required double productPrice,
    required int itemCount,
    required double totalAmount,
  }) {
    _descriptionTemplates.shuffle();
    String template = _descriptionTemplates.first;

    return template
        .replaceAll('{productName}', productName)
        .replaceAll('\${productPrice}', '\$${productPrice.toStringAsFixed(2)}')
        .replaceAll('{itemCount}', itemCount.toString())
        .replaceAll('\${totalAmount}', '\$${totalAmount.toStringAsFixed(2)}');
  }
}
