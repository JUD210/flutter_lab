import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // !!! 카메라 컨트롤러 초기화
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max, // !!! ResolutionPreset을 최대값으로 설정
      enableAudio: false, // !!! 오디오 비활성화
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // !!! 카메라 접근 권한 오류 처리
            debugPrint("CameraController Error : CameraAccessDenied");
            break;
          default:
            debugPrint("CameraController Error");
            break;
        }
      }
    });
  }

  // !!! 사진을 찍는 함수 정의
  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return;
    }
    try {
      final XFile file = await _controller.takePicture();
      // !!! 사진을 저장할 경로 지정
      Directory directory = Directory('storage/emulated/0/DCIM/MyImages');
      await Directory(directory.path).create(recursive: true);
      // !!! 지정한 경로에 사진 저장
      final savedImage =
          await File(file.path).copy('${directory.path}/${file.name}');
      if (mounted) {
        Navigator.of(context).pop(savedImage.path);
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Stack(
      children: [
        Positioned.fill(
          child: CameraPreview(_controller),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                // !!! 사진 촬영 버튼 클릭 이벤트 정의
                onTap: () {
                  _takePicture();
                },
                child: const Icon(
                  Icons.camera_enhance,
                  size: 70,
                  color: Colors.white,
                ),
              )),
        ),
      ],
    );
  }
}
