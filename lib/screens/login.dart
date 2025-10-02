import 'package:chat_app/screens/singup.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final void Function()? onTap;
  LoginScreen({super.key, this.onTap});
  void login(BuildContext context)async{
    final authService=AuthService();
    try{
       await authService.signInwithEmail(_emailController.text.trim(), _passController.text.trim());
    }
    catch(e){showDialog(context: context, builder: (context)=>AlertDialog(title: Text(e.toString()),));}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Center(
            child: Column(children: [
              const SizedBox(height:50),
          Image.asset('lib/assets/images/message.png',width:100,height:100),
          const SizedBox(height: 50),
          Text(
            'Login to your account',
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
          MyButton(
            text: 'Login',
            onTap: ()=>login(context),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account ? "),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: const Text(
                    "Register Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ])));
  }
}
