import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'photo.dart';
import 'dart:io';

void main() {
  runApp(const MyApp()); // 앱 실행 진입점
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GalleryPage(), // 메인 페이지 설정
    );
  }
}

// 1. 기초 플러터 앱 만들기 - 사진 갤러리 앱
// - 신규 프로젝트 photo_gallery를 만들어봅니다.
// - 기본 페이지인 갤러리 페이지를 구현합니다.
//   - GridView를 사용하여 여러 개의 사진들을 보여줍니다.
// - Photo 클래스를 만듭니다.
//   - id, url, title 등의 속성을 갖는 photo 클래스를 만듭니다.
// - Photo 클래스의 객체를 리스트에 담는 dummyPhotos를 만듭니다.
// - 그리드뷰를 통해서 사진들을 보여줍니다.

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: dummyPhotos.length,
        itemBuilder: (context, index) {
          final photo = dummyPhotos[index];
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
              child: Image.network(photo.url),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(photo.title),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 2. 네비게이션 및 데이터 전달 - 사진 상세 페이지 구현하기
// - 네비게이션 구현 (목록에서 상세 페이지로 이동)
// - 페이지 간 데이터 전달 (선택한 이미지 정보 전달)
// - 상세 페이지 UI 구성

class PhotoDetailPage extends StatelessWidget {
  final Photo photo;

  const PhotoDetailPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(photo.url),
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

// 3. 고급 UI 및 사용자 경험 - 카메라 기능 추가
// - 카메라 통합 및 촬영 기능 구현
// - 촬영한 사진을 갤러리에 추가하는 기능 구현

class GalleryGPTPageState extends State<GalleryPage> {
  File? _image;
  final List<Photo> _photos = [...dummyPhotos];

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _photos.add(Photo(
            id: _photos.length + 1,
            url: pickedFile.path,
            title: 'New Photo')); // 촬영한 사진을 추가
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery GPT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('카메라로 사진 촬영'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: _photos.length,
                itemBuilder: (context, index) {
                  final photo = _photos[index];
                  return GridTile(
                    child: Image.file(File(photo.url)),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(photo.title),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. API 통합 및 AI 서비스 구현 - 이미지 분류 또는 설명 기능 추가하기
// - 사전학습된 이미지 분류 모델 통합
// - 갤러리의 이미지 또는 새로 촬영한 이미지 분류 및 설명 기능 구현

Future<void> _classifyImageWithGPT(File image) async {
  // 여기서 GPT와 상호작용하는 부분을 가정해 볼게
  // 실제 GPT 모델을 사용하려면 서버와의 연동이 필요해
  setState(() {
    _classificationResult = "이 이미지는 해파리입니다."; // 임의의 결과 설정
  });
}

// 주요 설명:
// 1. ImagePicker를 사용해 갤러리 및 카메라에서 이미지를 선택하고,
// 2. 선택된 이미지를 화면에 보여주며,
// 3. classifyImageWithGPT()라는 함수에서 이미지를 분류하는 과정을 가정하여 처리 결과를 보여줌.
// 4. 페이지 간의 네비게이션과 데이터 전달을 포함하여, 촬영한 사진도 갤러리에 추가할 수 있도록 구현.
