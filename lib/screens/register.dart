import 'package:flutter/material.dart';
import 'package:thisismeapp/components/my_button.dart';
import 'package:thisismeapp/components/textfield.dart';
import 'package:thisismeapp/services/auth/auth_service.dart';

class Register extends StatelessWidget {
  Register({super.key, required this.onTap});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void Function()? onTap;
  void register(BuildContext context) {
    final auth = AuthService();
   if (passwordController.text == confirmpasswordController.text){
    try {
       auth.signUpWithEmailPassword(
        emailController.text, passwordController.text
        );
     }catch (e){
      showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
     }
    }
    else{
      showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  title: Text("Passwords Don't match"),
                ));
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
               Icon(
                Icons.person,
                size: 100,
                color: Colors.orange.shade800,
              ),
              const SizedBox(height: 50),
              Text(
                'Glad You\'ve Decided To Join Us',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: emailController,
                hintText: 'Enter Your Email',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: confirmpasswordController,
                hintText: ' Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: () => register(context),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
