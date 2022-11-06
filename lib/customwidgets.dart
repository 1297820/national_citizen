import 'package:flutter/material.dart';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, required this.text, required this.controller})
      : super(key: key);
  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(243, 245, 250, 1),
          borderRadius: BorderRadius.circular(6)),
      child: TextField(
        cursorColor: const Color.fromRGBO(154, 34, 240, 1),
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 5, 15),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: text,
            hintStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
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
      this.height = 45})
      : super(key: key);
  final String text;
  final Function() onpressed;
  double width;
  double height;

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
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ),
      ),
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
  void initState() {
    super.initState();
    values = "Married";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        hint: Text(
          values.toString(),
          style: const TextStyle(
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
            getX.write(Constants().GETX_STATUS, values);
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
  String? values = "Female";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      width: MediaQuery.of(context).size.width,
      child: DropdownButton<String>(
        hint: Text(
          values.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromRGBO(0, 0, 0, 0.7),
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
            getX.write(Constants().GETX_GENDER, values);
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
