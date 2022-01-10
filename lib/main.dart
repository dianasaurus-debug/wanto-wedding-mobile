import 'package:dream_wedding_app/Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(
      OverlaySupport(
          child:
          MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Splash Screen',
    home: SplashScreen(),
  )));
}