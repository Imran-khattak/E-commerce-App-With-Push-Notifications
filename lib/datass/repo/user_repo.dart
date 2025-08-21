import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notifications/datass/repo/auth_repositories.dart';
import 'package:notifications/model/user_model.dart';
import 'package:notifications/widgets/exceptions/firebase_auth_exceptions.dart';
import 'package:notifications/widgets/exceptions/firebase_exceptions.dart';
import 'package:notifications/widgets/exceptions/format_exceptions.dart';
import 'package:notifications/widgets/exceptions/platform_exceptions.dart';

class UserRepository with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async {
    try {
      // Clean the user data before saving
      final userData = user.toJson();
      return await db.collection("Users").doc(user.id).set(userData);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // More specific error message
      throw "Error saving user data: ${e.toString()}";
    }
  }

  //**----- Fetch user data base on Usesr id ------***/

  Future<UserModel> fetchUser() async {
    try {
      // Clean the user data before saving
      final authProvider = AuthenticationProvider();
      final documentSnapshot = await db
          .collection("Users")
          .doc(authProvider.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // More specific error message
      throw "Error saving user data: ${e.toString()}";
    }
  }

  Future<UserModel> getUsersDetails(String id) async {
    try {
      final snapshot = await db.collection("Users").doc(id).get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Try Again";
    }
  }

  //**----- Update user data in FireStore ------***/

  Future<void> updateUser(UserModel updateUser) async {
    try {
      await db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // More specific error message
      throw "Error saving user data: ${e.toString()}";
    }
  }

  //**----- Update Any field in User Section  in FireStore ------***/

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      final authProvider = AuthenticationProvider();
      await db.collection("Users").doc(authProvider.authUser?.uid).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // More specific error message
      throw "Error saving user data: ${e.toString()}";
    }
  }

  //**----- Remove User data from  FireStore ------***/

  Future<void> removeUserRecord(String id) async {
    try {
      await db.collection("Users").doc(id).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // More specific error message
      throw "Error saving user data: ${e.toString()}";
    }
  }

  // Upload Image to fireStorage...

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // More specific error message
      throw "Error saving user data: ${e.toString()}";
    }
  }
}
