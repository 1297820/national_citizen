import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/apirequest.dart';
import 'package:national_citizen/utils/constants.dart';

class PasswordCustomTextField extends StatelessWidget {
  PasswordCustomTextField(
      {Key? key,
      required this.text,
      required this.controller,
      required this.obscureText,
      required this.onPressed})
      : super(key: key);
  final String text;
  final TextEditingController controller;
  bool obscureText;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextField(
        obscureText: obscureText,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: const Color.fromRGBO(154, 34, 240, 1),
        controller: controller,
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(243, 245, 250, 1),
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 5, 15),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: text,
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(
              obscureText
                  ? Icons.visibility_off
                  : Icons.visibility, //change icon based on boolean value
              color: const Color.fromRGBO(154, 34, 240, 1),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.text,
      required this.onpressed,
      required this.width,
      this.height = 45,
      this.loadingState = 0})
      : super(key: key);
  final String text;
  final Function() onpressed;
  double width;
  double height;
  int loadingState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(154, 34, 240, 1),
                ),
                elevation: MaterialStateProperty.all<double>(0)),
            onPressed: onpressed,
            child: buildButtonChild(loadingState, text)),
      ),
    );
  }
}

Widget buildButtonChild(loadingState, text) {
  if (loadingState == 0) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(255, 255, 255, 1),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  } else if (loadingState == 1) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(color: Colors.white),
    );
  } else {
    return const SizedBox(
      height: 20,
      width: 20,
      child: Icon(Icons.check_rounded, color: Colors.white),
    );
  }
}

showMyDialog(
    {required BuildContext context,
    required String text,
    required double titleSize,
    required String content,
    required String buttonText,
    required double contentTextSize}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        title: Row(
          children: [
            const Spacer(),
            Text(
              text,
              style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(154, 34, 240, 1)),
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
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: contentTextSize),
        ),
        actions: <Widget>[
          Center(
            child: CustomButton(
              width: 128,
              height: 35,
              text: buttonText,
              onpressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}

class RelationshipStatus extends StatefulWidget {
  const RelationshipStatus({Key? key}) : super(key: key);

  @override
  State<RelationshipStatus> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<RelationshipStatus> {
  final status = ["Married", "Single"];

  String? values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        hint: const Text(
          'status',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
        ),
        value: values,
        items: status.map(buildItem).toList(),
        icon: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.55),
          child: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Color.fromRGBO(0, 0, 0, 0.7),
            size: 22,
          ),
        ),
        onChanged: (value) {
          setState(() {
            values = value;
            getX.write(user_details.GETX_STATUS, values);
            // getX.write('state', values);
          });
        },
      ),
    );
  }

  DropdownMenuItem<String> buildItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Row(
        children: [
          const SizedBox(
            width: 9.17,
          ),
          Text(
            item,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  final gender = ['Male', 'Female'];

  final years = DateTime.now().year;
  String? values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        hint: const Text(
          'F/M',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(0, 0, 0, 0.6),
          ),
        ),
        value: values,
        items: gender.map(buildItem).toList(),
        icon: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.55),
          child: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Color.fromRGBO(0, 0, 0, 0.7),
            size: 22,
          ),
        ),
        onChanged: (value) {
          setState(() {
            values = value;
            getX.write(user_details.GETX_GENDER, values);
            // getX.write('gender', values);
          });
        },
      ),
    );
  }

  DropdownMenuItem<String> buildItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          Text(
            item,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

void showToast(msg, backgroundColor) {
  Fluttertoast.showToast(
      msg: msg, // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.TOP,
      backgroundColor: backgroundColor // location
      );
}
