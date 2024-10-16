import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_testfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatelessWidget {
  //Email and pwd controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  // tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // register method
  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();

    //password match-> create match
    if(_confirmPwdController.text == _pwdController.text){
      try{
    _auth.signUpWithEmailPassword(_emailController.text, _pwdController.text);
      }
      catch(e){
        showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(e.toString()),
      ),);
      }
    }
    //password don't match
    else{
      showDialog(context: context, builder: (context)=> const AlertDialog(
        title: Text("Password don't match"),
      ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 50),
          //welcome back message
          Text(
            "Create an account!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),

          //email textfield
          MyTextField(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(height: 25),

          //pw textfield
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: _pwdController,
          ),

          //confirmPwd textfield
          MyTextField(
            hintText: "Confirm Password",
            obscureText: true,
            controller: _confirmPwdController,
          ),

          const SizedBox(height: 25),

          //login button
          MyButton(
            text: "Register",
            onTap: ()=> register(context),
          ),
          const SizedBox(height: 25),

          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
