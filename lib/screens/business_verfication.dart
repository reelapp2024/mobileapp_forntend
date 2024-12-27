import 'package:flutter/material.dart';

class BusinessVerifyDocumentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF2222), Color.fromARGB(255, 67, 21, 18)],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          // Title Text
          Positioned(
            top: 60,
            left: 16,
            child: Text(
              'Business Verification',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          // Content Box
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
                    Text(
                      'Please submit your business documents for verification with the government.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle redirection to government portal
                        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => GovernmentPortalScreen()));
                      },
                      child: Text('Go to Government Portal'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFFF2222),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Skip Button at the bottom
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: TextButton(
              onPressed: () {
                // Handle skip action
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
