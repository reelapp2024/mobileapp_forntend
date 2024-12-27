import 'package:flutter/material.dart';

class BusinessUnderReviewScreen extends StatelessWidget {
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
              'Business Under Review',
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
                    Icon(
                      Icons.hourglass_empty,
                      color: Colors.orange,
                      size: 50,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your business verification is under review. Please wait for confirmation.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle redirection to check status or retry
                        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => CheckStatusScreen()));
                      },
                      child: Text('Check Status'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
}
