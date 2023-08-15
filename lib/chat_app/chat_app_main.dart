import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_web/chat_app/screens/auth.dart';
import 'package:first_web/chat_app/screens/chat.dart';
import 'package:first_web/chat_app/screens/splash.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

Future<void> firebaseInitialize() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  log('firebase initialized.');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialize();
  runApp(const FlutterChatApp());
}

class FlutterChatApp extends StatelessWidget {
  const FlutterChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.hasData == true) {
            return const ChatScreen();
          }

          return const AuthScreen();
        },
      ),
    );
  }
}
