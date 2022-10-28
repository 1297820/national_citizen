import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:national_citizen/customwidgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              'Sign In',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const Text(
              'Welcome Back',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const Spacer(),
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
            const Spacer(),
            CustomButton(
              width: 230,
              text: 'Sign In',
              onpressed: () {
                // showMyDialog(
                //   context: context,
                //   text: 'Network Error',
                //   content:
                //       "Couldn't connect to database, Connect to the internet",
                //   buttonText: 'Try again');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: RichText(
                text: const TextSpan(
                  text: 'New user ',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins'),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                          color: Color.fromRGBO(173, 34, 224, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  _showMyDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 280),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          title: Row(
            children: [
              const Spacer(),
              const Text(
                'Sign In Failed',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(154, 34, 240, 1)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Color.fromRGBO(124, 119, 142, 1),
                ),
              ),
            ],
          ),
          content: const Text(
            'NIN or Password Incorrect, Please input your details correctly',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  width: 128,
                  height: 35,
                  text: 'Sign In',
                  onpressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: 35,
                  child: OutlinedButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                                color: Color.fromRGBO(154, 34, 240, 1)))),
                    onPressed: () {},
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(154, 34, 240, 1)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
