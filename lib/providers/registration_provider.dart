import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letmegrab_practical/screens/home_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationProvider extends ChangeNotifier{

  final registerKey = GlobalKey<FormState>();
  TextEditingController password=TextEditingController();
  TextEditingController email=TextEditingController();
  bool isNotVisible = true;
  RoundedLoadingButtonController btnController=RoundedLoadingButtonController();

  setPassVisibility(){
    isNotVisible=!isNotVisible;
    notifyListeners();
  }

  void onPress(BuildContext context){
    if (registerKey.currentState!.validate()) {
      register(context);
    }else{
      const snackBar = SnackBar(content: Text('Please Fill all Requirements'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      btnController.reset();
    }
  }

  register(BuildContext context) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      btnController.success();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user",credential.user!.uid.toString());
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The account already exists for that email.')),
        );


      }
      debugPrint("ERROR : "+e.message.toString());
      btnController.reset();
    } catch (e) {
      debugPrint(e.toString());
      btnController.reset();
    }
  }
}