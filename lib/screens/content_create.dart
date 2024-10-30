import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class ContentCreateScreen extends StatefulWidget {
  @override
  _ContentCreateScreenState createState() => _ContentCreateScreenState();
}

class _ContentCreateScreenState extends State<ContentCreateScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController; // Make TabController nullable
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeTabController();
    _initializeCamera();
  }

  void _initializeTabController() {
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraController = CameraController(cameras[0], ResolutionPreset.high);
      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _tabController?.dispose(); // Use nullable operator to dispose safely
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle the selected image (e.g., display or edit)
      print("Selected from gallery: ${image.path}");
    }
  }

  Widget _buildPostTab() {
    return Center(
      child: ElevatedButton(
        onPressed: _pickFromGallery,
        child: Text("Choose from Gallery"),
      ),
    );
  }

  Widget _buildCameraTab(String mode) {
    return _isCameraInitialized
        ? Stack(
            children: [
              CameraPreview(_cameraController!),
              Positioned(
                bottom: 50,
                child: Center(
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          mode == 'Reel' ? Icons.videocam : Icons.camera,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: () async {
                          if (mode == 'Reel') {
                            await _cameraController?.startVideoRecording();
                            // Handle video capture for reel
                          } else {
                            final image =
                                await _cameraController?.takePicture();
                            // Handle image capture for story
                            print(
                                "Captured ${mode.toLowerCase()}: ${image?.path}");
                          }
                        },
                      ),
                      Text(
                        "Capture $mode",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Content"),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Post"),
                  Tab(text: "Reel"),
                  Tab(text: "Story"),
                  Tab(text: "Live"),
                ],
              ),
      ),
      body: _tabController == null
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildPostTab(),
                _buildCameraTab("Reel"),
                _buildCameraTab("Story"),
                Center(child: Text("Live feature coming soon...")),
              ],
            ),
    );
  }
}
