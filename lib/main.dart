import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meditate_mantra_task/onBoarding/screens/splash_screen.dart';
import 'music/screens/loading_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Meditate Mantra',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
