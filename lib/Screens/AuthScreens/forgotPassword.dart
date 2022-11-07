import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/AuthScreens/passwordReset.dart';
import 'package:national_citizen/customwidgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Forgot Password',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const Text(
              'Recover Password',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                cursorColor: const Color.fromRGBO(154, 34, 240, 1),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  fillColor: Color.fromRGBO(243, 245, 250, 1),
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Email',
                  hintStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              width: 230,
              text: 'Reset',
              onpressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const PasswordResetScreen(),
                  ),
                );
              },
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
