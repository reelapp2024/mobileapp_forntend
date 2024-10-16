import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
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
            top: 60, // Adjust the position as needed
            left: 16, // Left padding
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
                    _buildTextField('Business Name', Icons.store),
                    SizedBox(height: 10),
                    _buildTextField('Categories', Icons.category),
                    SizedBox(height: 10),
                    _buildTextField('Sub-Categories', Icons.subtitles),
                    SizedBox(height: 10),
                    _buildTextField('Building Name', Icons.apartment),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child:
                                _buildTextField('Street', Icons.location_on)),
                        SizedBox(width: 10),
                        Expanded(
                            child: _buildTextField('Landmark', Icons.flag)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child:
                                _buildTextField('City', Icons.location_city)),
                        SizedBox(width: 10),
                        Expanded(child: _buildTextField('State', Icons.map)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField('Pin Code', Icons.pin_drop)),
                        SizedBox(width: 10),
                        Expanded(
                            child: _buildTextField('Country', Icons.public)),
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
                // Action when pressed
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

  Widget _buildTextField(String labelText, IconData icon) {
    return TextField(
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
