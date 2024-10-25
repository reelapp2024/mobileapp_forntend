import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class ReelScrollingScreen extends StatefulWidget {
  final String initialVideoUrl;
  final String username;
  final String caption;
  final String likes;
  final String comments;
  String views; // Non-final to allow updates

  ReelScrollingScreen({
    required this.initialVideoUrl,
    required this.username,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.views,
  });

  @override
  _ReelScrollingScreenState createState() => _ReelScrollingScreenState();
}

class _ReelScrollingScreenState extends State<ReelScrollingScreen> {
  VideoPlayerController? _controller;
  bool _isPlaying = true;
  bool _showPlayPauseIcon = false;
  bool _hasIncrementedView = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo(widget.initialVideoUrl);
  }

  void _initializeVideo(String videoUrl) {
    if (_controller != null) {
      _controller!.pause();
      _controller!.dispose();
    }

    _controller = VideoPlayerController.asset(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller!.play();
          _controller!.setLooping(true);
          _incrementViewCountOnce();
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  void _incrementViewCountOnce() {
    if (!_hasIncrementedView) {
      setState(() {
        int currentViews = int.parse(widget.views);
        widget.views = (currentViews + 1).toString();
      });
      _hasIncrementedView = true;
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller?.pause();
      } else {
        _controller?.play();
      }
      _isPlaying = !_isPlaying;
      _showPlayPauseIcon = true;
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        _showPlayPauseIcon = false;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _togglePlayPause,
        child: Stack(
          children: [
            Center(
              child: _controller?.value.isInitialized == true
                  ? VideoPlayer(_controller!)
                  : CircularProgressIndicator(),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "@${widget.username}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.caption,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Views: ${widget.views}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: _showPlayPauseIcon ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Center(
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildIconWithCount(Icons.favorite, widget.likes, Colors.red),
                  SizedBox(height: 20),
                  _buildIconWithCount(
                      Icons.comment, widget.comments, Colors.white),
                  SizedBox(height: 20),
                  _buildIcon(Icons.share, Colors.white),
                  SizedBox(height: 20),
                  _buildIcon(Icons.more_horiz, Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithCount(IconData icon, String count, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 30,
        ),
        SizedBox(height: 4),
        Text(
          count,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Icon(
      icon,
      color: color,
      size: 30,
    );
  }
}
