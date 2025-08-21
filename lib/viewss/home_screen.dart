import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:notifications/datass/services/notifications.dart';
import 'package:notifications/datass/services/send_notifications_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationsServices services = NotificationsServices();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    try {
      services.requestNotificationPermission();
      services.initNotifications(context);
      //  final token = await services.getDeviceToken();
      //  print("Device Token: $token");
    } catch (e) {
      print("Error initializing notifications: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Firebase Push Notifications Demo',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),

          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                EasyLoading.show();
                await SendNotificationsService.sendNotifications(
                  token:
                      "d9liY7TmS7i3Uis4FIOuLZ:APA91bHNDZXfhal43ceN-nuB8ZW0b-2i2F2eHK7PyrBtO084QQLMhPwr_OrZJ6thUBp1VKa9tBWhwkbQy1aNtVU_YrHQ7y-UP1nCM1s9p0LZXtxBwYNIWYU",
                  title: "Order Updates!",
                  body: "Your Order has been proceed!",
                  data: {},
                );
                EasyLoading.dismiss();
              },
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
