import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:national_citizen/Screens/botNavBarScreen/bottomNavBar.dart';
import 'package:national_citizen/custom_widgets.dart';
import 'package:national_citizen/utils/api_request.dart';
import '../../main.dart';
import 'SignInScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Map<String, dynamic>? signUp;
  TextEditingController emailController = TextEditingController();
  TextEditingController ninController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // The ninController, passwordController and emailController contains the nin, password and email inputs

  bool value = false;
  bool _obscureText = true;
  int loadingState = 0;
  bool errorText = false;


  void signUpFunction() async {
    Map<String, dynamic> response;
    response = await signUpRequest(
      emailController.text
          .toString()
          .trim(), //trim is used to remove whitespaces in the users input
      ninController.text.toString().trim(),
      passwordController.text.toString().trim(),
    );
    //The variable 'response' contains the feedback from the back end
    if (response["status"] == "ok" &&
        response["msg"] == "Successfully created user") {
      //If the request was successful, everthing within this block of code should be executed
      setState(() {
        loadingState = 2;
      });
      getX.write(user_details.GETX_NAME, response['user']["name"]);
      
      getX.write(user_details.GETX_STATUS, response['user']["status"]);
      getX.write(user_details.GETX_ADDRESS, response['user']["address"]);
      getX.write(user_details.GETX_PHONE_NUMBER, response['user']["phone"]);
      getX.write(user_details.GETX_EMAIL, response['user']["email"]);
      getX.write(user_details.GETX_DOB, response['user']["date_of_birth"]);
      getX.write(user_details.GETX_OCCUPATION, response['user']["occupation"]);
      getX.write(user_details.GETX_GENDER, response['user']["gender"]);
      getX.write(user_details.GETX_HEIGHT, response['user']["height"]);
      getX.write(user_details.GETX_INTEREST, response['user']["interest"]);
      getX.write(user_details.GETX_BIO, response['user']["bio"]);
      getX.write(user_details.GETX_IMAGE, response['user']["img"]);
      getX.write(user_details.GETX_TOKEN, response['token']);
      getX.write(user_details.GETX_ISLOGGEDIN, 'true');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomNavBar()),
        (route) => false,
      );
    } else {
      //If not, this should be executed instead
      showToast(response['msg'], Colors.red[700]);
      setState(() {
        loadingState = 0;
      });
      // showToast(response["msg"]);
    }
  }

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const Text(
                'Create your account',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 120,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  cursorColor: const Color.fromRGBO(154, 34, 240, 1),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    fillColor: Color.fromRGBO(243, 245, 250, 1),
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Email',
                    hintStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                height: 63,
                child: TextField(
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  controller: ninController,
                  cursorColor: const Color.fromRGBO(154, 34, 240, 1),
                  inputFormatters: [LengthLimitingTextInputFormatter(11)],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(243, 245, 250, 1),
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'NIN',
                    hintStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
                    errorText: errorText ? 'NIN must be 11 digits' : '',
                    errorStyle: const TextStyle(fontSize: 11),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordCustomTextField(
                text: 'Password',
                controller: passwordController,
                obscureText: _obscureText,
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; //change boolean value
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 18,
                    width: 18,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(243, 245, 250, 1)),
                    child: Checkbox(
                      side: BorderSide.none,
                      fillColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(243, 245, 250, 1),
                      ),
                      checkColor: const Color.fromRGBO(62, 66, 69, 0.8),
                      value: value,
                      onChanged: (value) {
                        setState(() {
                          this.value = !this.value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'I accept the ',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins'),
                      children: [
                        TextSpan(
                          text: 'Privacy Policy ',
                          style: TextStyle(
                              color: Color.fromRGBO(173, 34, 224, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins'),
                        ),
                        TextSpan(
                          text: 'and ',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins'),
                        ),
                        TextSpan(
                          text: 'Terms',
                          style: TextStyle(
                              color: Color.fromRGBO(173, 34, 224, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
              ),
              //The 'CustomButton' is a Widget manually created by us
              CustomButton(
                loadingState: loadingState,
                width: 230,
                text: 'Sign Up',
                onpressed: () {
                  //Everthing with in this function should run at the point this button is been tapped
                  if (ninController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    showToast('All field must field', Colors.red[700]);
                  } else if (ninController.text.length != 11) {
                    setState(() {
                      errorText = true;
                    });
                  } else if (!value) {
                    showToast("Accept terms of usage", Colors.red[700]);
                  } else {
                    // If all conditions required to successfully signUp has been met, then execute everthing
                    // in this block of code
                    setState(() {
                      loadingState = 1;
                    });
                    signUpFunction();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Existing user? ',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color.fromRGBO(173, 34, 224, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ninController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
