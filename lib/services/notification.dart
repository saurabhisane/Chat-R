import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> inNotification()async{

    await _firebaseMessaging.requestPermission();

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ Push notifications enabled!");
    } else {
      print(" Push notifications denied!");
    }

    // / final fcnToken = _firebaseMessaging.getToken();
    //
    // print("fcn token : $fcnToken");

  }


}