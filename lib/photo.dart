import 'dart:io';
import 'package:flutter/material.dart';

class Photo {
  final int id;
  final String url;
  final String title;

  Photo({required this.id, required this.url, required this.title});
}

final List<Photo> dummyPhotos = [
  Photo(id: 1, url: 'https://picsum.photos/200', title: 'Photo 1'),
  Photo(id: 2, url: 'https://picsum.photos/201', title: 'Photo 2'),
  Photo(id: 3, url: 'https://picsum.photos/199', title: 'Photo 3'),
  Photo(id: 4, url: 'https://picsum.photos/198', title: 'Photo 4'),
  Photo(id: 5, url: 'https://picsum.photos/202', title: 'Photo 5'),
];

Widget loadImage(Photo photo) {
  return photo.url.startsWith('http')
      ? Image.network(photo.url)
      : Image.file(File(photo.url));
}
