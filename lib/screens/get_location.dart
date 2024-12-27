import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({Key? key}) : super(key: key);

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TextEditingController _searchController = TextEditingController();

  LatLng? _currentLocation; // Stores the user's current location
  List<Marker> _markers = []; // List to store markers
  String _address = ""; // Address of the selected location
  String _city = ""; // City
  String _state = ""; // State
  String _pincode = ""; // Pincode

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Fetch user's current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      await Geolocator.openLocationSettings();
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    // Fetch the address details for the current location
    await _fetchAddressFromCoordinates(_currentLocation!);

    // Move the camera to the user's current location
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );

    // Add a marker at the current location
    _addMarker(_currentLocation!);
  }

  // Fetch address details (city, state, pincode) using reverse geocoding
  Future<void> _fetchAddressFromCoordinates(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        setState(() {
          _address =
              "${placemark.street ?? ""}, ${placemark.locality ?? ""}, ${placemark.subAdministrativeArea ?? ""}";
          _city = placemark.locality ?? "";
          _state = placemark.administrativeArea ?? "";
          _pincode = placemark.postalCode ?? "";
        });
      }
    } catch (e) {
      print("Error fetching address: $e");
    }
  }

  // Search location by address
  Future<void> _searchLocation() async {
    String address = _searchController.text;
    if (address.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {
          final location = locations.first;
          final GoogleMapController controller = await _controller.future;

          // Move the camera to the searched location
          controller.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(location.latitude, location.longitude),
            ),
          );

          // Add a marker to the searched location
          LatLng searchedPosition =
              LatLng(location.latitude, location.longitude);
          setState(() {
            _markers.add(
              Marker(
                markerId: MarkerId(address),
                position: searchedPosition,
                infoWindow: InfoWindow(title: address),
              ),
            );
          });

          // Fetch the address details for the searched location
          await _fetchAddressFromCoordinates(searchedPosition);
        }
      } catch (e) {
        print('Error finding location: $e');
      }
    }
  }

  // Add marker at tapped location
  void _addMarker(LatLng position) async {
    // Clear old markers
    setState(() {
      _markers = [];
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: '${position.latitude}, ${position.longitude}',
          ),
        ),
      );
    });

    // Fetch the address details for the selected location
    await _fetchAddressFromCoordinates(position);
  }

  // Confirm the selected location and return the data
  void _confirmLocation() {
    if (_city.isNotEmpty && _state.isNotEmpty && _pincode.isNotEmpty) {
      Navigator.pop(context, {
        "address": _address,
        "city": _city,
        "state": _state,
        "pincode": _pincode,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a location first."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Location...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchLocation,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _currentLocation == null
                ? Center(
                    child:
                        CircularProgressIndicator()) // Show loader until location is fetched
                : GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                      }
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    markers:
                        Set<Marker>.of(_markers), // Show markers on the map
                    onTap: _addMarker, // Add marker on tap
                  ),
          ),
          // Confirm Location button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _confirmLocation,
              child: Text("Confirm Location"),
            ),
          ),
        ],
      ),
    );
  }
}
