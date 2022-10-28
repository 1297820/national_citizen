import 'package:flutter/material.dart';

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

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.text,
      required this.onpressed,
      required this.width,
      this.height = 45})
      : super(key: key);
  final String text;
  final dynamic onpressed;
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
      return Expanded(
        child: AlertDialog(
          // insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 280),
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
            style: TextStyle(
              fontSize: contentTextSize
            ),
          ),
          actions: <Widget>[
            Center(
              child: CustomButton(
                width: 128,
                height: 35,
                text: buttonText,
                onpressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
