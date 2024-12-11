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

    // Move the camera to the user's current location
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
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
        ],
      ),
    );
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
          setState(() {
            _markers.add(
              Marker(
                markerId: MarkerId(address),
                position: LatLng(location.latitude, location.longitude),
                infoWindow: InfoWindow(title: address),
              ),
            );
          });
        }
      } catch (e) {
        print('Error finding location: $e');
      }
    }
  }

  // Add marker at tapped location
  void _addMarker(LatLng position) {
    setState(() {
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
  }
}
