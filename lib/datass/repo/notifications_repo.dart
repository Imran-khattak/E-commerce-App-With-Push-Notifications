// User-Aware Notifications Repository
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:notifications/model/nofications_model.dart';
import 'package:notifications/widgets/exceptions/firebase_exceptions.dart';
import 'package:notifications/widgets/exceptions/format_exceptions.dart';
import 'package:notifications/widgets/exceptions/platform_exceptions.dart';

class NotificationsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'notifications';

  // Save notification to Firestore with user ID
  Future<void> saveNotifications(NotificationsModel notification) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(notification.id)
          .set(notification.toFirestore());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(
        "Failed to save notification to Firestore: ${e.toString()}",
      );
    }
  }

  // Fetch notifications for a specific user
  Future<List<NotificationsModel>> fetchUserNotifications(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => NotificationsModel.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(
        "Failed to fetch user notifications from Firestore: ${e.toString()}",
      );
    }
  }

  // Mark single notification as seen for specific user
  Future<void> markAsSeen(String notificationId, String userId) async {
    try {
      // Verify the notification belongs to the user before updating
      final docSnapshot = await _firestore
          .collection(_collection)
          .doc(notificationId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception("Notification not found");
      }

      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data['userId'] != userId) {
        throw Exception("Unauthorized access to notification");
      }

      await _firestore.collection(_collection).doc(notificationId).update({
        'isSeen': true,
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception("Failed to mark notification as seen: ${e.toString()}");
    }
  }

  // Mark all notifications as read for specific user (batch operation)
  Future<void> markAllAsRead(
    List<String> notificationIds,
    String userId,
  ) async {
    try {
      // First verify all notifications belong to the user
      final docs = await Future.wait(
        notificationIds.map(
          (id) => _firestore.collection(_collection).doc(id).get(),
        ),
      );

      // Check ownership
      for (var doc in docs) {
        if (!doc.exists) continue;
        final data = doc.data() as Map<String, dynamic>;
        if (data['userId'] != userId) {
          throw Exception("Unauthorized access to notification");
        }
      }

      // Use batch write for better performance
      final WriteBatch batch = _firestore.batch();

      for (String notificationId in notificationIds) {
        final DocumentReference docRef = _firestore
            .collection(_collection)
            .doc(notificationId);
        batch.update(docRef, {'isSeen': true});
      }

      // Commit the batch
      await batch.commit();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(
        "Failed to mark all notifications as read: ${e.toString()}",
      );
    }
  }

  // Get unread count for specific user
  Future<int> getUserUnreadCount(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('isSeen', isEqualTo: false)
          .get();

      return querySnapshot.size;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception("Failed to get user unread count: ${e.toString()}");
    }
  }

  // Delete notification for specific user
  Future<void> deleteUserNotification(
    String notificationId,
    String userId,
  ) async {
    try {
      // Verify the notification belongs to the user before deleting
      final docSnapshot = await _firestore
          .collection(_collection)
          .doc(notificationId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception("Notification not found");
      }

      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data['userId'] != userId) {
        throw Exception("Unauthorized access to notification");
      }

      await _firestore.collection(_collection).doc(notificationId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception("Failed to delete user notification: ${e.toString()}");
    }
  }
}
