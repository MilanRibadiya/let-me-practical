import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letmegrab_practical/providers/login_provider.dart';
import 'package:letmegrab_practical/screens/registration.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    debugPrint("Build");

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: SizedBox(
                height: constraints.maxHeight,
                child: Consumer<LoginProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Form(
                      key: value.loginKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: TextFormField(
                                controller: value.email,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(40)
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'E-mail',),

                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return 'Please enter Email';
                                  }else{
                                    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                                      return null;
                                    }
                                    return "Please enter valid Email";
                                  }
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Consumer<LoginProvider>(
                                builder: (BuildContext context, v, Widget? child){
                                  return TextFormField(
                                    controller: value.password,
                                    obscureText: v.isNotVisible,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30)
                                    ],
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            value.setPassVisibility();
                                          },
                                          icon: Icon(v.isNotVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        )
                                    ),
                                    validator: (value){
                                      if(value==null || value.isEmpty){
                                        return 'Please enter Password';
                                      }
                                      return null;
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              height: 50,
                              width: 250,
                              child: RoundedLoadingButton(
                                controller: value.btnController,
                                onPressed: () {
                                  value.onPress(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Registration()));
                              },
                              child: const Text('New User? Create Account',style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),),),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
