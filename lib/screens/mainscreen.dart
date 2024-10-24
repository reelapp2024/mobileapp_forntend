import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logical_dottech/constant/color_const.dart';
import 'package:logical_dottech/screens/profilescreen.dart';
import 'package:logical_dottech/widgets/bottomnavigationbar.dart';
import 'chat_screen.dart'; // Import your ChatScreen

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1; // Default to BusinessTypeScreen or whichever you want

  // List of pages corresponding to the bottom navigation bar items
  final List<Widget> _pages = [
    // Other screens can be added here as needed
    ProfileScreen(),
    ChatScreen(),

    // Add other screens here
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Show the current page
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected, // Handle tab selection
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttoncolor,
        onPressed: () {
          // Handle FAB action
        },
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white, // Border color
            width: 2.0, // Border width
          ),
        ),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
