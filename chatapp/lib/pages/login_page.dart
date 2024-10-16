import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_testfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'pages/login_p'

class LoginPage extends StatelessWidget {
  //Email and pwd controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  // tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // login method
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwdController.text);
    }
    catch(e){
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text(e.toString()),
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
            "Welcome back, you've been missed!",
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
          //pw textfield
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: _pwdController,
          ),

          const SizedBox(height: 25),

          //login button
          MyButton(
            text: "Login",
            onTap: ()=> login(context),
          ),
          const SizedBox(height: 25),

          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register now",
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
