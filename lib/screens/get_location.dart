// import 'package:flutter/material.dart';
// // Import Ola Maps SDK (replace with the actual package)
// import 'package:ola_maps/ola_maps.dart'; // Example package name
// import 'package:ola_maps/models/lat_lng.dart'; // If Ola Maps has LatLng support

// class OlaMapScreen extends StatefulWidget {
//   @override
//   _OlaMapScreenState createState() => _OlaMapScreenState();
// }

// class _OlaMapScreenState extends State<OlaMapScreen> {
//   OlaMapController? _mapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Ola Map"),
//         centerTitle: true,
//       ),
//       body: OlaMapView(
//         apiKey: "Nhu8sLZbFBoVzwtURSkOX9fhN5ubMa8vVWo0kwfe", // Replace with your API key
//         initialPosition: LatLng(12.9716, 77.5946), // Replace with the initial latitude & longitude
//         zoom: 12.0,
//         onMapCreated: (controller) {
//           setState(() {
//             _mapController = controller;
//           });
//         },
//         markers: {
//           // Example marker
//           Marker(
//             position: LatLng(12.9716, 77.5946),
//             title: "Bangalore",
//             snippet: "This is a marker in Bangalore",
//           ),
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.location_searching),
//         onPressed: () async {
//           if (_mapController != null) {
//             // Example: Center the map on a specific location
//             await _mapController?.moveCamera(
//               LatLng(13.0827, 80.2707), // New position (Chennai, for example)
//             );
//           }
//         },
//       ),
//     );
//   }
// }
