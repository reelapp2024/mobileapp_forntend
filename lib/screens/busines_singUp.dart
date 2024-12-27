import 'package:flutter/material.dart';

class BusinessSignUpScreen extends StatefulWidget {
  @override
  _BusinessSignUpScreenState createState() => _BusinessSignUpScreenState();
}

class _BusinessSignUpScreenState extends State<BusinessSignUpScreen> {
  // Controllers for each text field
  TextEditingController _legalBusinessNameController = TextEditingController();
  TextEditingController _legalPersonNameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _subCategoryController = TextEditingController();

  bool _isOtpButtonVisible = false; // For showing OTP button

  // Build the TextField widget with label, hint, and controller
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon:
              Icon(Icons.person), // You can change the icon based on field type
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF2222), Color.fromARGB(255, 67, 21, 18)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 16,
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Legal Business Shop Name
                    _buildTextField(
                      label: 'Legal Business Shop Name',
                      hint: 'Enter your business name',
                      controller: _legalBusinessNameController,
                    ),
                    // Legal Person Name
                    _buildTextField(
                      label: 'Legal Person Name',
                      hint: 'Enter the name of the person in charge',
                      controller: _legalPersonNameController,
                    ),
                    // Business Category Dropdown
                    DropdownButtonFormField<String>(
                      items: [
                        'Food',
                        'Health and Wellness',
                        'Automotive',
                        'Travel',
                        'Education',
                        'Real Estate',
                        'Beauty & Personal Care',
                        'Wedding Planner'
                      ]
                          .map((category) => DropdownMenuItem(
                                child: Text(category),
                                value: category,
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Handle category selection
                      },
                      decoration:
                          InputDecoration(labelText: 'Business Category'),
                    ),
                    SizedBox(height: 16),
                    // Business Sub-Category Dropdown
                    DropdownButtonFormField<String>(
                      items: [
                        'Sub-category 1',
                        'Sub-category 2'
                      ] // Dynamically populate based on selected category
                          .map((subCategory) => DropdownMenuItem(
                                child: Text(subCategory),
                                value: subCategory,
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Handle sub-category selection
                      },
                      decoration:
                          InputDecoration(labelText: 'Business Sub Category'),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
