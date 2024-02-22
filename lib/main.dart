import 'package:flutter/material.dart';
import 'package:klinik/components/notif.dart';
import 'package:klinik/screens/admin/home/admin_home_screen.dart';
import 'package:klinik/screens/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAgE-7YYs1wgAwNIMq0woAYx8F3eTc5aI0",
      appId: "1:49362728091:android:5d15279422b0cf0219c23e",
      messagingSenderId: "49362728091",
      projectId: "klinik-dan-rekam-medis",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
