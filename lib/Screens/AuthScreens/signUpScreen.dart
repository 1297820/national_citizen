import 'package:flutter/material.dart';
import 'package:national_citizen/customwidgets.dart';

import 'SignInScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController ninController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              'Sign Up',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const Text(
              'Create your account',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const Spacer(),
            CustomTextField(
              text: 'Email',
              controller: emailController,
            ),
            const SizedBox(
              height: 18,
            ),
            CustomTextField(
              text: 'NIN',
              controller: ninController,
            ),
            const SizedBox(
              height: 18,
            ),
            CustomTextField(
              text: 'Password',
              controller: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 18,
                  width: 18,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(243, 245, 250, 1)),
                  child: Checkbox(
                    side: BorderSide.none,
                    fillColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(243, 245, 250, 1),
                    ),
                    checkColor: const Color.fromRGBO(62, 66, 69, 0.8),
                    value: value,
                    onChanged: (value) {
                      setState(() {
                        this.value = !this.value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                  text: const TextSpan(
                    text: 'I accept the ',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins'),
                    children: [
                      TextSpan(
                        text: 'Privacy Policy ',
                        style: TextStyle(
                            color: Color.fromRGBO(173, 34, 224, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Poppins'),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Poppins'),
                      ),
                      TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                            color: Color.fromRGBO(173, 34, 224, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(width: 230, text: 'Sign Up', onpressed: () {}),
            
            
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Existing user? ',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color.fromRGBO(173, 34, 224, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
