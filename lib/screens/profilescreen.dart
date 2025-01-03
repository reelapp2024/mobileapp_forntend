import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logical_dottech/app_route.dart';
import 'package:logical_dottech/constant/image_const.dart';
import 'package:logical_dottech/screens/playlist_detail_screen.dart';

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

// Initial position (hidden)
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      if (_isDrawerOpen) {
// Close the drawer
      } else {
// Open the drawer
      }
      _isDrawerOpen = !_isDrawerOpen;
    });
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
                Positioned(
                  top: 16, // Adjust the distance from the top of the screen
                  right:
                      16, // Adjust the distance from the right edge of the screen
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 30, // You can adjust the size of the icon here
                  ),
                ),
                Container(
                  height: 140, // Adjust height for cover photo
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets
                          .coverphoto), // Replace with your background image
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.5), // Black overlay with opacity
                  ),
                ),
                Positioned(
                  top: 30, // Adjust the distance from the top of the screen
                  right:
                      6, // Adjust the distance from the right edge of the screen
                  child: IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white, size: 30),
                    onPressed: () {
                      // Handle 3 dots click (open menu or options)
                    },
                  ),
                ),
                Positioned(
                  top: 30, // Adjust the distance from the top of the screen
                  right:
                      48, // Adjust the distance from the right edge of the screen (next to the three dots)
                  child: IconButton(
                    icon: Icon(Icons.share, color: Colors.white, size: 30),
                    onPressed: () {
                      // Handle share click (share functionality)
                    },
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
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '@brandnm',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Latest Trendy Clothing'
                          ', For Orders DM or WhatsApp 0000000000'
                          ', Cash on Delivery available 👌',
                          // '👉 Both Retail & Wholesale\n'
                          // '👉 Ship Allover 🇮🇳',
                          style: TextStyle(
                              fontSize: 14, fontFamily: 'Montserrat-Black'),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 16),

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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Center the columns
                          children: [
                            // First Column (Followers)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Followers number inside the Container
                                Container(
                                  height: 50,
                                  width: 70,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .white, // White background for each column
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 5.0,
                                        spreadRadius: 2.0,
                                        offset: Offset(0, 2), // Shadow position
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Optional: rounded corners
                                  ),
                                  child: Center(
                                    child: Text(
                                      '4,5k',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: 8), // Space between number and text
                                Text(
                                  'Followers',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),

                            // Second Column (Rating)
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors
                                    .white, // White background for each column
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    8.0), // Optional: rounded corners
                              ),
                              child: Column(
                                children: [
                                  Text('4.5', style: TextStyle(fontSize: 16)),
                                  Text('Rating',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),

                            // Third Column (Services)
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors
                                    .white, // White background for each column
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    8.0), // Optional: rounded corners
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.person),
                                  Text('Services')
                                ],
                              ),
                            ),

                            // Fourth Column (Area)
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors
                                    .white, // White background for each column
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    8.0), // Optional: rounded corners
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.location_city),
                                  Text('Area'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

                  // SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: Container(
                  //         height: 40,
                  //         width: 150,
                  //         decoration: BoxDecoration(
                  //             color: AppColors.primary1Color,
                  //             borderRadius: BorderRadius.circular(12)),
                  //         child: Center(
                  //           child: Text(
                  //             "Edit Profile",
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: Container(
                  //         height: 40,
                  //         width: 150,
                  //         decoration: BoxDecoration(
                  //             color: AppColors.primaryColor,
                  //             borderRadius: BorderRadius.circular(12)),
                  //         child: Center(
                  //           child: Text(
                  //             "Share",
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10),
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
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildGridContent(), // All Posts tab content
                  _buildReelsContent(context), // Reels tab content
                  _buildPlaylistContent(), // Playlist tab content
                  _buildProductsContent(), // Products tab content
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build content for Products tab
  Widget _buildProductsContent() {
    List<Map<String, String>> productsData = [
      {
        'productUrl': 'https://www.example.com/product1.jpg',
        'productName': 'Product 1',
      },
      {
        'productUrl': 'https://www.example.com/product2.jpg',
        'productName': 'Product 2',
      },
      {
        'productUrl': 'https://www.example.com/product3.jpg',
        'productName': 'Product 3',
      },
      // Add more products as needed
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust number of columns as needed
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: productsData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          // onTap: () {
          //   // Handle product tap, e.g., navigate to a product detail page
          //   Get.toNamed(AppRoutes.productDetailScreen, arguments: {
          //     'productUrl': productsData[index]['productUrl']!,
          //   });
          // },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(productsData[index]['productUrl']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  productsData[index]['productName']!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Build content for All Posts tab
  Widget _buildGridContent() {
    List<Map<String, String>> postData = [
      {
        'imageUrl': 'assets/Mobile-login 1.png', // Use local asset paths
        'caption': 'Check out this beautiful sunset!',
      },
      {
        'imageUrl': 'assets/Mobile-login 1.png',
        'caption': 'Had a great time at the beach!',
      },
      {
        'imageUrl': 'assets/Mobile-login 1.png',
        'caption': 'Delicious food at my favorite restaurant.',
      },
      {
        'imageUrl': 'assets/Mobile-login 1.png',
        'caption': 'Exploring the mountains.',
      },
      {
        'imageUrl': 'assets/Mobile-login 1.png',
        'caption': 'Loved this outfit I wore today!',
      },
      // Add more posts as needed
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns in grid
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: postData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          // Uncomment this if you want to navigate on tap
          // onTap: () {
          //   Get.toNamed(AppRoutes.postDetailScreen, arguments: {
          //     'imageUrl': postData[index]['imageUrl']!,
          //     'caption': postData[index]['caption']!,
          //   });
          // },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(postData[index]
                    ['imageUrl']!), // Use AssetImage for local assets
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReelsContent(BuildContext context) {
    List<Map<String, dynamic>> videoData = [
      {
        'videoUrl': 'assets/videoplayback.mp4',
        'thumbnailUrl': 'assets/3dLuM0uZ9sA-MQ.jpg',
        'views': '2000',
        'likes': '200',
        'comments': '50',
        'caption': 'This is reel 1 caption',
      },
      {
        'videoUrl': 'assets/videoplayback.mp4',
        'thumbnailUrl': 'assets/3dLuM0uZ9sA-MQ.jpg',
        'views': '999',
        'likes': '350',
        'comments': '75',
        'caption': 'This is reel 2 caption',
      },
      {
        'videoUrl': 'assets/videoplayback.mp4',
        'thumbnailUrl': 'assets/3dLuM0uZ9sA-MQ.jpg',
        'views': '897',
        'likes': '500',
        'comments': '120',
        'caption': 'This is reel 3 caption',
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: videoData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            // Navigate to ReelScrollingScreen and pass the video URL and additional data
            final updatedViews =
                await Get.toNamed(AppRoutes.reelscreen, arguments: {
              'videoUrl': videoData[index]['videoUrl']!,
              'views': videoData[index]['views']!,
              'caption': videoData[index]['caption']!,
              'likes': videoData[index]['likes']!,
              'comments': videoData[index]['comments']!,
            });

            // Update the views count if returned
            if (updatedViews != null) {
              setState(() {
                videoData[index]['views'] = updatedViews;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(videoData[index]['thumbnailUrl']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    Text(
                      videoData[index]['views']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaylistContent() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: 5, // Number of playlists
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.only(bottom: 16.0),
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              // Navigate to the playlist details screen where users can view/edit reels
              _navigateToPlaylistDetail(index);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Playlist Cover Image
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: AssetImage(
                          AppAssets.profilepic), // Playlist cover image
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Add overlay for the number of videos in the playlist
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '16 Videos', // Example: number of videos in the playlist
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Playlist Title
                      Text(
                        'WhatsApp Marketing and Automations Course',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Playlist Description
                      Text(
                        'View full playlist',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToPlaylistDetail(int index) {
    // Navigate to a screen where users can add/view multiple reels in the playlist
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistDetailScreen(playlistIndex: index),
      ),
    );
  }

  void _addStory() {
    setState(() {
      storyCount += 1;
    });
  }
}
