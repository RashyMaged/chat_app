import 'package:chat_app/screens/login.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  final void Function()? onTap;
  RegisterScreen({super.key, this.onTap});
  void register(BuildContext context)async {
    final authService = AuthService();
    if (_passController.text == _confirmpassController.text) {
      try {
       await authService.signUpwithEmail(
            _emailController.text, _passController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Center(
            child: Column(children: [
          const SizedBox(height: 50),
          Image.asset('lib/assets/images/message.png',width:100,height:100),
          const SizedBox(height: 50),
          Text(
            'Register a new account',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 25),
          CustomTextfield(
              hintText: 'Email', obstxt: false, controller: _emailController),
          const SizedBox(height: 16),
          CustomTextfield(
            hintText: 'Password',
            obstxt: true,
            controller: _passController,
          ),
          const SizedBox(height: 25),
          CustomTextfield(
            hintText: 'Confirm Password',
            obstxt: true,
            controller: _confirmpassController,
          ),
          const SizedBox(height: 25),
          MyButton(
            text: 'Register',
            onTap: () => register(context),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account ? "),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text(
                    "Login Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ])));
  }
}
