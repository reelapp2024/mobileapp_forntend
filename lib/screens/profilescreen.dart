import 'package:flutter/material.dart';
import 'package:logical_dottech/constant/color_const.dart';
import 'package:logical_dottech/constant/image_const.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int storyCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Four tabs
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip
                  .none, // This allows the profile image to overflow outside the cover photo
              children: [
                // Cover photo
                Container(
                  height: 140, // Adjust height for cover photo
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets
                          .coverphoto), // Replace with your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Profile photo
                Positioned(
                  top: 90, // Adjusted to overlap cover photo
                  left: 16,
                  child: Container(
                    width: 90, // Set the width for the circle
                    height: 90, // Set the height for the circle
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            AppAssets.profilepic), // Your profile image
                        fit: BoxFit
                            .contain, // Ensures the image covers the entire circle without distortion
                      ),
                    ),
                  ),
                ),

                // Camera icon at the bottom right of the profile photo, on the border
                Positioned(
                  top:
                      147, // Adjust to sit on the lower right corner of the profile image
                  left:
                      85, // Shift it towards the right bottom corner of the circle
                  child: GestureDetector(
                    onTap: () {
                      // Handle edit profile image
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white, // White background circle
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red, // Red inner circle
                        child: Icon(Icons.camera_alt,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 45),
            // Rest of the profile info and tabs below
            // Your other code goes here
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brand Name',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '@brandnm',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text('244', style: TextStyle(fontSize: 16)),
                                  Text('Posts', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              SizedBox(width: 16),
                              Column(
                                children: [
                                  Text('4,588', style: TextStyle(fontSize: 16)),
                                  Text('Followers',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              SizedBox(width: 16),
                              Column(
                                children: [
                                  Text('4.5', style: TextStyle(fontSize: 16)),
                                  Text('Rating',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        'Latest Trendy Clothing\n'
                        '👉 For Orders DM or WhatsApp 0000000000\n'
                        '👉 Cash on Delivery available 👌\n'
                        '👉 Both Retail & Wholesale\n'
                        '👉 Ship Allover 🇮🇳',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Handle tap for location link
                    },
                    child: Text(
                      'Trade Centre, South Tukoganj, Indore, Madhya Pradesh 452001',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle edit profile
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttoncolor),
                        onPressed: () {
                          // Handle share profile
                        },
                        child: Text(
                          'Share Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttoncolor),
                        onPressed: () {
                          // Handle message
                        },
                        child: Text(
                          'Message',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // STORY HIGHLIGHTS SECTION
                  Column(
                    children: [
                      // Story highlights container (Instagram-style)
                      Container(
                        height: 100, // Height of the highlight section
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10 + 1, // Extra 1 for "Add Story" button
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              // Add Story button
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Handle Add Story tap
                                        _addStory(); // Call the function to add a story
                                      },
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey
                                              .shade300, // Placeholder color
                                        ),
                                        child: Icon(
                                          Icons
                                              .add, // Plus icon to indicate adding a story
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'Add Story',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // Existing stories (index starts from 1 because index 0 is for "Add Story")
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Column(
                                  children: [
                                    // Story highlight cover
                                    Container(
                                      width:
                                          70, // Width and height for each highlight
                                      height: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 2,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://example.com/story-${index}.jpg'), // Replace with story highlight image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    // Story highlight label
                                    Text(
                                      'Story $index',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            // Tabs (All Posts, Reels, Playlist, Products)
            TabBar(
              controller: _tabController,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.red,
              tabs: [
                Tab(text: 'All Posts'),
                Tab(text: 'Reels'),
                Tab(text: 'Playlist'),
                Tab(text: 'Products'),
              ],
            ),
            SizedBox(
              height: 300, // Fixed height for TabBarView
              child: Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildGridContent(), // All Posts tab content
                    _buildGridContent(), // Reels tab content
                    _buildGridContent(), // Playlist tab content
                    _buildGridContent(), // Products tab content
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.buttoncolor,
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.message),
              onPressed: () {},
            ),
            SizedBox(width: 40), // Center the FAB
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.buttoncolor,
        onPressed: () {
          // Handle FAB action
        },
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white, // Border color
            width: 2.0, // Border width
          ),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildGridContent() {
    // Calculate the number of columns based on screen width
    int crossAxisCount = (MediaQuery.of(context).size.width / 120)
        .floor(); // 120 can be adjusted for spacing

    return GridView.count(
      crossAxisCount: crossAxisCount,
      children: List.generate(9, (index) {
        return Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage(AppAssets.profilepic), // Replace with post images
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }

  void _addStory() {
    // Logic to handle adding a new story
    // For example, you could open a camera or file picker here
    setState(() {
      // After adding the story, increase the number of stories
      // This is a placeholder. You'd handle the story data more robustly.
      storyCount += 1;
    });
  }
}
