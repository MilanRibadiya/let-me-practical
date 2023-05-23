import 'package:flutter/material.dart';
import 'package:letmegrab_practical/providers/home_provider.dart';
import 'package:letmegrab_practical/providers/login_provider.dart';
import 'package:letmegrab_practical/providers/registration_provider.dart';
import 'package:letmegrab_practical/screens/home_page.dart';
import 'package:letmegrab_practical/screens/login.dart';
import 'package:letmegrab_practical/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>LoginProvider()),
        ChangeNotifierProvider(create: (_)=>RegistrationProvider()),
        ChangeNotifierProvider(create: (_)=>HomeProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
