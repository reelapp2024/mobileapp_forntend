import 'package:flutter/material.dart';
import 'package:logical_dottech/constant/color_const.dart';
// If you're using GetX for navigation

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.buttoncolor,
      // shape: CircularNotchedRectangle(),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.person),
              onPressed: () => onTabSelected(0)), // Handle Person icon action
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.message),
              onPressed: () => onTabSelected(1)), // Handle Message icon action
          SizedBox(width: 40), // Center the FAB
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.notifications),
              onPressed: () =>
                  onTabSelected(2)), // Handle Notification icon action
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.settings),
              onPressed: () => onTabSelected(3)), // Handle Settings icon action
        ],
      ),
    );
  }
}
