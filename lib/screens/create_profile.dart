import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logical_dottech/constant/color_const.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  // Controllers for form fields
  final TextEditingController brandController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  // List of services keywords for suggestions
  final List<String> servicesKeywords = [
    'Marketing',
    'Design',
    'Development',
    'Consulting',
    'Photography',
    'Writing',
  ];
  String? selectedKeyword;

  // Form validation function
  void createProfile() {
    if (brandController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        bioController.text.isNotEmpty &&
        areaController.text.isNotEmpty &&
        selectedKeyword != null) {
      // Proceed to create the profile
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Created Successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
            'Create Profile',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with gradient and rounded shape

                  SizedBox(height: 20),

                  // Form fields
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                            label: 'Brand/Shop Name',
                            hint: 'Enter Brand/Shop Name',
                            controller: brandController),
                        _buildTextField(
                            label: 'Username',
                            hint: 'Enter Username',
                            controller: usernameController),
                        _buildTextField(
                            label: 'Bio',
                            hint: 'Enter Bio',
                            controller: bioController,
                            maxLines: 3),
                        _buildTextField(
                            label: 'Area Served',
                            hint: 'Enter Area Served',
                            controller: areaController),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedKeyword,
                          hint: Text('Select Service Keyword'),
                          items: servicesKeywords
                              .map((keyword) => DropdownMenuItem(
                                    value: keyword,
                                    child: Text(keyword),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedKeyword = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Service Keyword',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Submit Button
        Positioned(
          bottom: 30,
          right: 30,
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed('/mainscreen');
            },
            backgroundColor: Color(0xFFFF2222),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }

  // Helper method to build text fields
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
          prefixIcon: Icon(Icons.person),
        ),
      ),
    );
  }

  @override
  void dispose() {
    brandController.dispose();
    usernameController.dispose();
    bioController.dispose();
    areaController.dispose();
    super.dispose();
  }
}
