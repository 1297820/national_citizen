import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/botNavBarScreen/bottomNavBar.dart';
import 'package:national_citizen/Screens/settingsEdit/editScreen.dart';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/apirequest.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  List<String> settings = [
    "Name",
    "Status",
    "Address",
    "Phone number",
    "Email",
    "Date of birth",
    "Occupation",
    "Gender",
    "Height",
    "Interest",
    "Bio",
  ];

  List userDetails = [
    getX.read(user_details.GETX_NAME),
    getX.read(user_details.GETX_STATUS),
    getX.read(user_details.GETX_ADDRESS),
    getX.read(user_details.GETX_PHONE_NUMBER),
    getX.read(user_details.GETX_EMAIL),
    getX.read(user_details.GETX_DOB),
    getX.read(user_details.GETX_OCCUPATION),
    getX.read(user_details.GETX_GENDER),
    getX.read(user_details.GETX_HEIGHT),
    getX.read(user_details.GETX_INTEREST),
    getX.read(user_details.GETX_BIO)
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
        physics: const BouncingScrollPhysics(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      settings[index],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(0, 0, 0, 0.7),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "${userDetails[index]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              const Flexible(
                                flex: 1,
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Color.fromRGBO(164, 34, 205, 1),
                                ),
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
