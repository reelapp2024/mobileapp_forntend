import 'package:flutter/material.dart';
import 'package:logical_dottech/constant/color_const.dart';
import 'package:get/get.dart';

class BusinessTypeScreen extends StatefulWidget {
  @override
  _BusinessTypeScreenState createState() => _BusinessTypeScreenState();
}

class _BusinessTypeScreenState extends State<BusinessTypeScreen> {
  // List of business types
  List<String> businessTypes = [
    "Wholesaler",
    "Service Provider",
    "Retail",
    "Manufacturer",
  ];

  // Set to store selected business types
  Set<String> _selectedBusinessTypes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF2222), Color.fromARGB(255, 67, 21, 18)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          // Title
          Positioned(
            top: 60,
            left: 16,
            child: Text(
              'Select Business Type',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          // White container for form
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Generate cards for each business type with radio button
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: businessTypes.length,
                      itemBuilder: (context, index) {
                        // Determine if the current item is selected
                        bool isSelected = _selectedBusinessTypes
                            .contains(businessTypes[index]);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedBusinessTypes
                                    .remove(businessTypes[index]);
                              } else {
                                _selectedBusinessTypes
                                    .add(businessTypes[index]);
                              }
                            });
                          },
                          child: Container(
                            height: 70,
                            margin: const EdgeInsets.only(bottom: 16.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary1Color
                                    : Colors.grey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                              color:
                                  Colors.transparent, // Transparent background
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Custom Radio Button
                                  Radio<String>(
                                    value: businessTypes[index],
                                    groupValue: isSelected
                                        ? businessTypes[index]
                                        : null,
                                    activeColor: AppColors
                                        .primary1Color, // Change to your primary color
                                    onChanged: (value) {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedBusinessTypes
                                              .remove(businessTypes[index]);
                                        } else {
                                          _selectedBusinessTypes
                                              .add(businessTypes[index]);
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  // Business Type Text
                                  Text(
                                    businessTypes[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Floating Action Button for Submit
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: _selectedBusinessTypes.isNotEmpty
                  ? () {
                      Get.toNamed('/mainscreen');
                      // Action when pressed, e.g., navigate to the next screen
                      print("Selected Business Types: $_selectedBusinessTypes");
                    }
                  : null, // Disable if no selection
              backgroundColor: _selectedBusinessTypes.isNotEmpty
                  ? AppColors.primary1Color
                  : Colors.grey, // Color when enabled, grey when disabled
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
