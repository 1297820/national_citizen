import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/botNavBarScreen/home.dart';
import 'package:national_citizen/Screens/botNavBarScreen/profile.dart';
import 'package:national_citizen/Screens/botNavBarScreen/search.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    Key? key,
    this.index,
  }) : super(key: key);
  int? index;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int current_index = 0;

  void update_index(int value) {
    setState(() {
      current_index = value;
    });
  }

  @override
  initState() {
    super.initState();
    if (widget.index != null) {
      current_index = widget.index!;
    }
  }

  @override
  Widget build(BuildContext context) {
    //The list "screens" contains all pages to be accessed from the bottomNavBar
    List<Widget> screens = [
      const HomeScreen(),
      const SearchScreen(),
      const ProfileScreen()
    ];

    return Scaffold(
      body: IndexedStack(
        children: screens,
        index: current_index,
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        backgroundColor: Colors.grey.shade200,
        type: BottomNavigationBarType.fixed,
        currentIndex: current_index,
        onTap: update_index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 5,
        unselectedFontSize: 5,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 5, top: 3),
              child: Icon(
                Icons.home_outlined,
                color: Color.fromRGBO(164, 34, 231, 1),
                size: 30,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                size: 30, color: Color.fromRGBO(0, 0, 0, 0.5)),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 5, top: 3),
              child: Icon(Icons.search,
                  size: 30, color: Color.fromRGBO(164, 34, 231, 1)),
            ),
            label: 'Delivery History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 30,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 5, top: 3),
              child: Icon(Icons.account_circle_outlined,
                  size: 30, color: Color.fromRGBO(164, 34, 231, 1)),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
