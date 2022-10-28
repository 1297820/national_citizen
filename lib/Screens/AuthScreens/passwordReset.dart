import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:national_citizen/customwidgets.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController confirmPasswordController = TextEditingController();
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
              'Password',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const Text(
              'Enter password',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const Spacer(),
            CustomTextField(
              text: 'Type password',
              controller: passwordController,
            ),
            const SizedBox(
              height: 18,
            ),
            CustomTextField(
              text: 'Re-type password',
              controller: confirmPasswordController,
            ),
            const Spacer(),
            CustomButton(
              width: 230,
              text: 'Confirm',
              onpressed: () {
                // showMyDialog(
                //   context: context,
                //   text: 'Network Error',
                //   content:
                //       "Couldn't connect to database, Connect to the internet",
                //   buttonText: 'Try again');
              },
            ),
            const Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }
}
