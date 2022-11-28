import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:national_citizen/Screens/startScreen.dart';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/api_request.dart';
import 'package:share_plus/share_plus.dart';
import '../../custom_widgets.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  List<String> settings = ["Invite a friend", "About us", "Help", "Log out"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.keyboard_backspace_rounded,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            ...List.generate(
              settings.length,
              (index) {
                return Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(bottom: 8, top: 4)
                      : const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Share.share("invite a friend");
                      } else if (index == 1) {
                        Share.share("We help you connect with people");
                      } else if (index == 2) {
                        Share.share("Get help here");
                      } else if (index == 3) {
                        _showMyDialog(context);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(4),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          settings[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(45, 38, 75, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(
              flex: 6,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/images/settings.svg',
                height: 80,
              ),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  _showMyDialog(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            title: Row(
              children: [
                const Spacer(),
                const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(154, 34, 240, 1),
                  ),
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
              'Are you sure you want to log\nout of this account?',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 128,
                    height: 35,
                    text: 'No',
                    onpressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 35,
                    width: 135,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                            color: Color.fromRGBO(154, 34, 240, 1),
                          ),
                        ),
                      ),
                      onPressed: () {
                        getX.write(user_details.GETX_ISLOGGEDIN, 'false');
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const StartScreen(),
                            ),
                            (route) => false);
                      },
                      child: const Text(
                        'Yes',
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
          ),
        );
      },
    );
  }
}
