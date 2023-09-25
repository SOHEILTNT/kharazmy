import 'package:financial_management/screens/home_screen.dart';

import 'package:financial_management/screens/profile_screen.dart';
import 'package:financial_management/screens/registation_screen.dart';

import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/money.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget body = HomeScreen();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          inactiveColor: Colors.black54,
          icons: const [Icons.home, Icons.account_box, ],
          activeIndex: currentIndex,
          gapLocation: GapLocation.end,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (index) {
    
            if(index==0){
              body = const HomeScreen();
            }
    
            else{
              body = ProfilePage(
                firstName: RegistrationPage.firstNameController.text,
                lastName: RegistrationPage.lastNameController.text,
                email: RegistrationPage.emailController.text,
              );
            }
           
    
            setState(() {
              currentIndex = index ;
            });
          },
        ),
        body: body,
      ),
    );
  }
}