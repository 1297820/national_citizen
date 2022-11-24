import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:national_citizen/Screens/AuthScreens/forgotPassword.dart';
import 'package:national_citizen/Screens/AuthScreens/signUpScreen.dart';
import 'package:national_citizen/Screens/botNavBarScreen/bottomNavBar.dart';
import 'package:national_citizen/customwidgets.dart';
import 'package:national_citizen/main.dart';
import 'package:national_citizen/utils/apirequest.dart';
import 'package:national_citizen/utils/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController ninController = TextEditingController(); 
  TextEditingController passwordController = TextEditingController();
  // THe ninController and passwordController contains the nin and password inputs
  bool value = false;
  bool _obscureText = true;
  int loadingState = 0;

  //This function acts as the waiter in a resturant and sends the users request to logIn into his already created account
  //then returns a feedback, either the request was succeccful or not.
  logInFunction() async {
    print('******** rannnnnn');
    Map<String, dynamic> response;
    response = await logInRequest(
      ninController.text.toString().trim(),
      passwordController.text.toString().trim(),
    );
    //The variable 'response' contains the feedback from the back end 
    if (response["status"] == "ok" &&
        response["msg"] == "Successfully logged in") {
      //If the request was successful, everthing within this block of code should be executed
      setState(() {
        loadingState = 2;
      });
      getX.write(user_details.GETX_NAME, response['user']["name"]);
      print(" name updated  ${getX.read(user_details.GETX_NAME)}");
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
      print(" image updated  ${getX.read(user_details.GETX_IMAGE)}");
      getX.write(user_details.GETX_TOKEN, response['token']);
      getX.write(user_details.GETX_ISLOGGEDIN, 'true');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavBar()),
          (route) => false);
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
                'Sign In',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const Text(
                'Welcome Back',
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
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'NIN',
                    hintStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    errorText: ninController.text.length != 11 && ninController.text.isNotEmpty
                        ? 'NIN must be 11 digits long'
                        : '',
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
                height: 120,
              ),
              CustomButton(
                width: 230,
                text: 'Sign In',
                loadingState: loadingState,
                onpressed: () {
                 if (ninController.text.isEmpty || passwordController.text.isEmpty){
                   showToast('All field must field', Colors.red[700]);
                 }
                 else {
                  setState(() {
                    loadingState = 1;
                  });
                  logInFunction();
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
                    'New user? ',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Color.fromRGBO(173, 34, 224, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //This function displays an alert dialog on our screen but it's currently not in use
  _showMyDialog() {
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
                  'Sign In Failed',
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
              'NIN or Password Incorrect, Please input your details correctly',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    width: 128,
                    height: 35,
                    text: 'Sign In',
                    onpressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: 35,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                            color: Color.fromRGBO(154, 34, 240, 1),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Reset Password',
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
