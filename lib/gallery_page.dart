import 'package:flutter/material.dart';
import 'photo.dart';
import 'photo_detail_page.dart';
import 'camera.dart';
import 'package:camera/camera.dart';

class GalleryPage extends StatefulWidget {
  final CameraDescription camera;

  const GalleryPage({super.key, required this.camera});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<Photo> _photos = List.from(dummyPhotos);

  void _addPhoto(String imagePath) {
    setState(() {
      _photos.add(Photo(
          id: _photos.length + 1,
          url: imagePath,
          title: 'New Photo ${_photos.length + 1}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () async {
              final imagePath = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TakePictureScreen(camera: widget.camera),
                ),
              );
              if (imagePath != null) {
                _addPhoto(imagePath);
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          final photo = _photos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoDetailPage(photo: photo),
                ),
              );
            },
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(photo.title),
              ),
              child: loadImage(photo),
            ),
          );
        },
      ),
    );
  }
}
