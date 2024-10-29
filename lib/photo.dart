class Photo {
  final int id;
  final String url;
  final String title;

  Photo({required this.id, required this.url, required this.title});
}

final List<Photo> dummyPhotos = [
  Photo(id: 1, url: 'https://via.placeholder.com/150', title: 'Photo 1'),
  Photo(id: 2, url: 'https://via.placeholder.com/150', title: 'Photo 2'),
  Photo(id: 3, url: 'https://via.placeholder.com/150', title: 'Photo 3'),
  Photo(id: 4, url: 'https://via.placeholder.com/150', title: 'Photo 4'),
  Photo(id: 5, url: 'https://via.placeholder.com/150', title: 'Photo 5'),
];
