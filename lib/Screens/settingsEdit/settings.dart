import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => MyAccount()));
                      } else if (index == 1) {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => Notifications()));
                      } else if (index == 2) {
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => Security()));
                      } else if (index == 3) {
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => AboutUs()));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      // height: 54,
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
                        // shape: BoxShape.circle,
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
            const Spacer(),
            Center(
              child: SvgPicture.asset(
                'assets/images/settings.svg',
                height: 80,
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
