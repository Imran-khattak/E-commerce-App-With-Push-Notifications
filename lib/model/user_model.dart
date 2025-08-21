import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String fullName;
  String deviceToken;

  final String email;

  String profilePicture;

  UserModel({
    required this.id,
    required this.fullName,
    required this.deviceToken,

    required this.email,

    required this.profilePicture,
  });

  static UserModel empty() => UserModel(
    id: '',
    fullName: '',
    email: '',
    profilePicture: '',
    deviceToken: '',
  );

  // Convert Usermodel into Json formate...

  Map<String, dynamic> toJson() {
    return {
      'FullName': fullName,
      'DeviceToken': deviceToken,

      'Email': email,

      'ProfilePicture': profilePicture,
    };
  }

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        fullName: data['FullName'] ?? '',
        deviceToken: data['DeviceToken'] ?? '',
        email: data['Email'] ?? '',

        profilePicture: data['ProfilePicture'] ?? '',
      );
    }
    return UserModel.empty();
  }

  // Add this copyWith method
  UserModel copyWith({
    String? id,
    String? fullName,
    String? deviceToken,
    String? email,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      deviceToken: deviceToken ?? this.deviceToken,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, deviceToken: $deviceToken, email: $email, profilePicture: $profilePicture)';
  }
}
