import 'dart:async';

import 'package:flutter/material.dart';
import 'package:letmegrab_practical/screens/home_page.dart';
import 'package:letmegrab_practical/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }


  void init() async{
    final prefs = await SharedPreferences.getInstance();
    final String? user= prefs.getString("user");
    if(user!=null){
      Timer(
          const Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomePage())));
    }else{
      Timer(
          const Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
          'https://media.licdn.com/dms/image/C4E0BAQEolcTFY8wKpA/company-logo_200_200/0/1640181359296?e=1691020800&v=beta&t=ULFjLwLUnqO5bO_xOAXQmrH_DelCj7BoHfVRx6BRWe4',
        ),
      ),
    );
  }
}
