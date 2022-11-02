import 'package:flutter/material.dart';
import 'package:national_citizen/customwidgets.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  EditScreen({Key? key, required this.editValue}) : super(key: key);
  String editValue;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  int day = 11;
  int month = 12;
  int year = 1997;
  TextEditingController editController = TextEditingController();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // height: 143,
            width: double.infinity,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(241, 241, 241, 1)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.editValue == "Date of birth"
                        ? "Date of birth"
                        : 'Enter your ${widget.editValue}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(45, 38, 75, 1),
                    ),
                  ),
                  widget.editValue == "Date of birth"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: GestureDetector(
                            onTap: () {
                              calender();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              246, 232, 251, 1),
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                162, 162, 162, 1),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4),),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        child: Text(
                                          "$day",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Color.fromRGBO(45, 38, 75, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'DD',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(45, 38, 75, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              246, 232, 251, 1),
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                162, 162, 162, 1),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        child: Text(
                                          "$month",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromRGBO(45, 38, 75, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'MM',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(45, 38, 75, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              246, 232, 251, 1),
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                162, 162, 162, 1),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        child: Text(
                                          "$year",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Color.fromRGBO(45, 38, 75, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'YY',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(45, 38, 75, 1),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : TextField(
                          controller: editController,
                          cursorColor: const Color.fromRGBO(154, 34, 240, 1),
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(154, 34, 240, 1),
                              ),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                            hintText: 'Eric Walt',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(62, 66, 69, 1),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showMyDialog(
                            context: context,
                            text: 'Error',
                            titleSize: 22,
                            contentTextSize: 12,
                            content:
                                ' Character too long. Input 20 characters or lesser. ',
                            buttonText: 'OK',
                          );
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  DateTime currentDate = DateTime.now();

  calender() async {
    DateTime? dateOfBirth = await showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(1990),
      lastDate: DateTime(2022),
      helpText: '2022',
      initialEntryMode: DatePickerEntryMode.calendarOnly,

      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Theme( 
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: Color.fromRGBO(246, 232, 251, 1) ,
                  onPrimary: Color.fromRGBO(0, 0, 0, 0.64),
                  onSurface: Color.fromRGBO(0, 0, 0, 0.8)       
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: const Color.fromRGBO(127, 126, 130, 1), // button text color
                ),
              ),
            ),
            child: child!,
          ),
        )
      },
    );
    if (dateOfBirth != null) {
      setState(() {
        day = dateOfBirth.day;
        year = dateOfBirth.year;
        month = dateOfBirth.month;
        print(day);
      });
    }
  }
}
