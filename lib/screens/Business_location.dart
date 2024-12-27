import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Add geolocator package to pubspec.yaml
import 'package:http/http.dart'
    as http; // Add http package to send data to your API
import 'get_location.dart'; // Import GetLocation screen

class BusinessLocationScreen extends StatefulWidget {
  @override
  _BusinessLocationScreenState createState() => _BusinessLocationScreenState();
}

class _BusinessLocationScreenState extends State<BusinessLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return; // Location services are not enabled; handle accordingly
    }

    // Request permission if not granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return; // Permissions are denied forever; handle accordingly
      }
    }

    _currentPosition = await Geolocator.getCurrentPosition();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> formData = {
        "buildingNo": _buildingController.text,
        "street": _streetController.text,
        "city": _cityController.text,
        "state": _stateController.text,
        "pincode": _pincodeController.text,
        "latitude": _currentPosition?.latitude,
        "longitude": _currentPosition?.longitude,
      };

      final response = await http.post(
        Uri.parse('https://yourapi.com/submit-location'),
        body: formData,
      );

      if (response.statusCode == 200) {
        print('Data submitted successfully');
      } else {
        print('Failed to submit data');
      }
    }
  }

  Future<void> _openMapScreen() async {
    final Map<String, String>? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GetLocation(),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _cityController.text = selectedLocation['city'] ?? '';
        _stateController.text = selectedLocation['state'] ?? '';
        _pincodeController.text = selectedLocation['pincode'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    _buildingController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    super.dispose();
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
            'Current Location',
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Location (Actual location of your business)",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _buildingController,
                            decoration: InputDecoration(
                              labelText: "Building No.",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter building number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _streetController,
                            decoration: InputDecoration(
                              labelText: "Street",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter street';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: _openMapScreen,
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Select Location",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              labelText: "City (Auto Fetch)",
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please wait, fetching city';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _stateController,
                            decoration: InputDecoration(
                              labelText: "State (Auto Fetch)",
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please wait, fetching state';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _pincodeController,
                            decoration: InputDecoration(
                              labelText: "Pincode (Auto Fetch)",
                              border: OutlineInputBorder(),
                            ),
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please wait, fetching pincode';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _submitForm,
                            child: Text("Submit"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
