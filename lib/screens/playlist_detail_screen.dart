import 'package:flutter/material.dart';
import 'package:logical_dottech/constant/image_const.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final int playlistIndex;

  PlaylistDetailScreen({required this.playlistIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Details'),
      ),
      body: ListView.builder(
        itemCount: 10, // Number of reels in the playlist
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
            title: Text('Reel Title $index',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('5 mins • 1.2K views',
                style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              // Handle reel tap
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new reel to playlist
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
