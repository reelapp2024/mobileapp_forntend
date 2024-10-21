import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List of chats (you can dynamically update this list in a real app)
  List<Map<String, dynamic>> chatList = [
    {
      'profilePic': 'assets/profile1.png',
      'userName': 'Jayshree Shah',
      'message': 'Lorem Ipsum is simply dummy te...',
      'time': '10:22 AM',
      'unreadCount': '9+',
    },
    {
      'profilePic': 'assets/profile2.png',
      'userName': 'Shruti Jaiswal',
      'message': 'Lorem Ipsum is simply dummy te...',
      'time': 'Yesterday',
      'unreadCount': '2',
    },
    {
      'profilePic': 'assets/profile3.png',
      'userName': 'Lakshya Verma',
      'message': 'Photo',
      'time': 'Yesterday',
      'isPhoto': true,
    },
    {
      'profilePic': 'assets/profile4.png',
      'userName': 'Jayesh Patel',
      'message': 'Lorem Ipsum is simply dummy te...',
      'time': 'Thursday',
    },
    {
      'profilePic': 'assets/profile5.png',
      'userName': 'Rohan Rathore',
      'message': 'Lorem Ipsum is simply dummy te...',
      'time': 'Monday',
    },
  ];

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

          // Title and List of Chats
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 16.0),
                child: Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(
                      top: 30), // Add margin to create rounded effect
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      final chat = chatList[index];
                      return _buildChatTile(
                        profilePic: chat['profilePic'],
                        userName: chat['userName'],
                        message: chat['message'],
                        time: chat['time'],
                        unreadCount: chat['unreadCount'],
                        isPhoto: chat['isPhoto'] ?? false,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // Floating Action Button to Add New Chat
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewChat,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  // Method to dynamically add a new chat
  void _addNewChat() {
    setState(() {
      chatList.add({
        'profilePic': 'assets/profile_new.png',
        'userName': 'New User',
        'message': 'Hey! How are you?',
        'time': 'Now',
        'unreadCount': '1',
      });
    });
  }

  // Widget to build each chat item
  Widget _buildChatTile({
    required String profilePic,
    required String userName,
    required String message,
    required String time,
    String? unreadCount,
    bool isPhoto = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage(profilePic), // User's profile image
          ),
          SizedBox(width: 12),

          // Chat Details (Name, Message, Time)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Name and Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),

                // Message Preview and Unread Count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (isPhoto)
                          Icon(
                            Icons.photo,
                            size: 16,
                            color: Colors.grey,
                          ),
                        SizedBox(width: isPhoto ? 4 : 0),
                        Text(
                          message,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    // Unread Message Count (if available)
                    if (unreadCount != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          unreadCount,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
