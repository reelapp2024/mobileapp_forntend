import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  // Placeholder variables for profile photo and cover photo
  String? coverPhotoPath;
  String? profilePhotoPath;

  // Form validation function
  void createProfile() {
    if (brandController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        bioController.text.isNotEmpty &&
        areaController.text.isNotEmpty &&
        selectedKeyword != null &&
        profilePhotoPath != null &&
        coverPhotoPath != null) {
      // Proceed to create the profile
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Created Successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and add photos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF2222), Color.fromARGB(255, 67, 21, 18)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          // Header text
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
          // Form container
          Positioned(
            top: 120,
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
                    SizedBox(height: 20),
                    // Cover Photo
                    _buildImagePicker(
                      label: 'Cover Photo',
                      onPick: (path) {
                        setState(() {
                          coverPhotoPath = path;
                        });
                      },
                      placeholder: coverPhotoPath,
                    ),
                    SizedBox(height: 20),
                    // Profile Photo/Logo
                    _buildImagePicker(
                      label: 'Profile Photo/Logo',
                      onPick: (path) {
                        setState(() {
                          profilePhotoPath = path;
                        });
                      },
                      placeholder: profilePhotoPath,
                    ),
                    SizedBox(height: 20),
                    // Form fields
                    _buildTextField(
                      label: 'Brand/Shop Name',
                      hint: 'Enter Brand/Shop Name',
                      controller: brandController,
                    ),
                    _buildTextField(
                      label: 'Username',
                      hint: 'Enter Username',
                      controller: usernameController,
                    ),
                    _buildTextField(
                      label: 'Bio',
                      hint: 'Enter Bio',
                      controller: bioController,
                      maxLines: 3,
                    ),
                    _buildTextField(
                      label: 'Area Served',
                      hint: 'Enter Area Served',
                      controller: areaController,
                    ),
                    SizedBox(height: 10),
                    // Dropdown for service keyword
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
                    SizedBox(height: 30),
                    // Create Profile Button
                    Center(
                      child: ElevatedButton(
                        onPressed: createProfile,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          backgroundColor: Color(0xFFFF2222),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Create Profile',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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

  // Helper method to build an image picker field
  Widget _buildImagePicker({
    required String label,
    required Function(String) onPick,
    String? placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            // Simulate picking an image
            onPick('path/to/selected/image.jpg');
          },
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              image: placeholder != null
                  ? DecorationImage(
                      image: AssetImage(placeholder),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: placeholder == null
                ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                : null,
          ),
        ),
      ],
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
