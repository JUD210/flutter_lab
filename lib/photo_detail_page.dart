import 'package:flutter/material.dart';
import 'photo.dart';

class PhotoDetailPage extends StatelessWidget {
  final Photo photo;
  const PhotoDetailPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.of(context).pop(photo.id); // 삭제 버튼 클릭 시 사진 ID 반환
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loadImage(photo),
            const SizedBox(height: 20),
            Text(
              photo.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
