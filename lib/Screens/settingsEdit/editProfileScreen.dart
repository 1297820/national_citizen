import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/settingsEdit/editScreen.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  List<String> settings = [
    "Name",
    "Address",
    "Phone number",
    "Email",
    "Date of birth",
    "Occupation",
    "Address",
    "Gender",
    "Height",
    "Interest",
    "Bio",
  ];

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
          'Profile Edit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(45, 38, 75, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditScreen(
                              editValue: settings[index],
                            ),
                          ),
                        );
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
                          child: Row(
                            children: [
                              Text(
                                settings[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(45, 38, 75, 1),
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.edit_outlined,
                                color: Color.fromRGBO(45, 38, 75, 0.6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
