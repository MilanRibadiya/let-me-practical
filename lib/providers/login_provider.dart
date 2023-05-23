import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letmegrab_practical/screens/home_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier{

  final loginKey = GlobalKey<FormState>();
  TextEditingController password=TextEditingController();
  TextEditingController email=TextEditingController();
  bool isNotVisible = true;
  RoundedLoadingButtonController btnController=RoundedLoadingButtonController();


  setPassVisibility(){
    isNotVisible=!isNotVisible;
    notifyListeners();
  }

  void onPress(BuildContext context){
    if (loginKey.currentState!.validate()) {
      login(context);
    }else{
      const snackBar = SnackBar(content: Text('Please Fill all Requirements'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      btnController.reset();
    }
  }

  login(BuildContext context) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim()
      );


      final prefs = await SharedPreferences.getInstance();
      debugPrint(credential.user!.uid.toString());
      await prefs.setString("user",credential.user!.uid.toString());
      btnController.success();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong password provided for that user.')),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString())),
        );
      }
      email.clear();
      password.clear();
      btnController.reset();
    }
  }
}