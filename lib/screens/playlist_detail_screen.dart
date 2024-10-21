import 'package:flutter/material.dart';
import 'package:logical_dottech/constant/image_const.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final int playlistIndex;

  PlaylistDetailScreen({required this.playlistIndex});

  @override
  _PlaylistDetailScreenState createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  List<String> reelTitles =
      []; // List to store reel titles for future state management

  @override
  void initState() {
    super.initState();
    // Initialize or fetch data for reels in the playlist
    // This is just dummy data; you can replace it with actual reel data
    reelTitles = List.generate(10, (index) => 'Reel Title $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Details'),
      ),
      body: ListView.builder(
        itemCount: reelTitles.length, // Number of reels in the playlist
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.profilepic), // Thumbnail for reel
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(reelTitles[index],
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('5 mins • 1.2K views',
                style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              // Handle reel tap
              print('Tapped on: ${reelTitles[index]}');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new reel to playlist (for example purposes, just adding a new dummy reel)
          setState(() {
            reelTitles.add('Reel Title ${reelTitles.length}');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
