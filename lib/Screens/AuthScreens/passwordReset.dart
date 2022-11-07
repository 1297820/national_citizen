import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/botNavBarScreen/bottomNavBar.dart';
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
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  
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
            PasswordCustomTextField(
              text: 'Type password',
              controller: passwordController,
              obscureText: _obscureText1,
              onPressed: () {
                setState(() {
                  _obscureText1 = !_obscureText1; //change boolean value
                });
              },
            ),
            const SizedBox(
              height: 18,
            ),
            PasswordCustomTextField(
              text: 'Re type password',
              controller: confirmPasswordController,
              obscureText: _obscureText2,
              onPressed: () {
                setState(() {
                  _obscureText2 = !_obscureText2; //change boolean value
                });
              },
            ),
            const Spacer(),
            CustomButton(
              width: 230,
              text: 'Confirm',
              onpressed: () {
                _showMyDialog();
              },
            ),
            const Spacer(
              flex: 3,
            )
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
              const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          title: Row(
            children: [
              const Spacer(),
              const Text(
                'Password Reset',
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
            'Recovery link sent to your email',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 128,
                height: 35,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(154, 34, 240, 1),
                      ),
                      elevation: MaterialStateProperty.all<double>(0)),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.check,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
