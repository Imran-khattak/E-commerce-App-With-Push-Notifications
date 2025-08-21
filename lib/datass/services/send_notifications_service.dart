import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:notifications/datass/services/get_server_key.dart';
import 'package:http/http.dart' as http;

class SendNotificationsService {
  static Future<void> sendNotifications({
    required String? token,
    required String? title,
    required String? body,
    required Map<String, dynamic>? data,
  }) async {
    String serverKey = await GetServerKey().getServerToken();
    print("Server Key : $serverKey");
    String url =
        "https://fcm.googleapis.com/v1/projects/push-notifications-46d17/messages:send";

    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer $serverKey",
    };
    Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {"body": body, "title": title},
        "data": data,
      },
    };

    // Hit api...
    final response = await http.post(
      Uri.parse(url),
      headers: header,
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Notifications Send Successfully!");
      }
    } else {
      if (kDebugMode) {
        print("Notifications Failed");
        print(" Api Response ${response.body}");
      }
    }
  }
}
