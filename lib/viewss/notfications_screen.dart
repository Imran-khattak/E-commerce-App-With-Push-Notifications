import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotficationsScreen extends StatelessWidget {
  final RemoteMessage message;
  const NotficationsScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Notifications page",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message.notification!.title.toString()),
            SizedBox(height: 20),
            Text(message.notification!.body.toString()),
          ],
        ),
      ),
    );
  }
}
