import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/botNavBarScreen/bottomNavBar.dart';
import 'package:national_citizen/Screens/startScreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:national_citizen/utils/api_request.dart';

final getX = GetStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect Us',
      theme: ThemeData(fontFamily: "Poppins"),
      home: getX.read(user_details.GETX_ISLOGGEDIN) == 'true'
          ? BottomNavBar()
          : const StartScreen(),
    );
  }
}
