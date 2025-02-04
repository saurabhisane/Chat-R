import 'package:chat_app/screens/chat_messages.dart';
import 'package:chat_app/screens/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  setupPushNotification() async {
    try {
      final fcm = FirebaseMessaging.instance;
      await fcm.requestPermission();
      final token = await fcm.getToken();
      if (token != null) {
        print("FCM Token: $token");
      } else {
        print("Failed to get FCM token");
      }
      print(token);
    } catch (error) {
      print("Error setting up push notifications: $error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupPushNotification();
  }

  void logout() async {
    try {
      await _auth.signOut(); // Await the signOut method
      Get.offAll(() => const LoginPage()); // Navigate to LoginPage
    } catch (error) {
      print("Logout error: $error"); // Log a ny errors
      Get.snackbar(
        'Logout Error',
        'An error occurred while logging out.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          actions: [
            IconButton(
              onPressed: logout, // Call the logout function
              icon: const Icon(Icons.exit_to_app),
              color: Colors.white,
            ),
          ],
          title: const Text('Chat'),
          backgroundColor: Colors.purple,
          elevation: 4.0,
        ),
        body: Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessages(),
          ],
        ));
  }
}
