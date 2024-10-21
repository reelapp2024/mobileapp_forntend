import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // You can use TextEditingControllers if you want to get the form values
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();
  final TextEditingController _buildingNameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF2222), Color.fromARGB(255, 67, 21, 18)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          // Title "Sign Up"
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
          // White form container
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Fill up your all the details and attach all the necessary documents to get fast approved. Thanks!!!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Form fields
                    _buildTextField(
                        'Business Name', Icons.store, _businessNameController),
                    SizedBox(height: 10),
                    _buildTextField(
                        'Categories', Icons.category, _categoryController),
                    SizedBox(height: 10),
                    _buildTextField('Sub-Categories', Icons.subtitles,
                        _subCategoryController),
                    SizedBox(height: 10),
                    _buildTextField('Building Name', Icons.apartment,
                        _buildingNameController),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField('Street', Icons.location_on,
                                _streetController)),
                        SizedBox(width: 10),
                        Expanded(
                            child: _buildTextField(
                                'Landmark', Icons.flag, _landmarkController)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(
                                'City', Icons.location_city, _cityController)),
                        SizedBox(width: 10),
                        Expanded(
                            child: _buildTextField(
                                'State', Icons.map, _stateController)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField('Pin Code', Icons.pin_drop,
                                _pinCodeController)),
                        SizedBox(width: 10),
                        Expanded(
                            child: _buildTextField(
                                'Country', Icons.public, _countryController)),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Map Placeholder
                    Text(
                      'Select Your Current Location',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      color: Colors.grey[300], // Placeholder for map
                      child: Center(
                        child: Text('Google Map Placeholder'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Floating action button for submission
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                // Perform submission action here
                // You can access the form field values using the controllers
                print('Business Name: ${_businessNameController.text}');
              },
              backgroundColor: Color(0xFFFF2222),
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

  // A reusable method for building TextFields
  Widget _buildTextField(
      String labelText, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
