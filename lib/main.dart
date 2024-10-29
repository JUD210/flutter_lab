import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'gallery_page.dart';
import 'camera.dart';

Future<void> main() async {
  // 앱이 실행되기 전에 필요한 초기화 작업을 수행하는 메서드
  // main 함수에서만 호출 가능
  // 사용가능한 카메라를 확인하기 위함
  WidgetsFlutterBinding.ensureInitialized();

  // 사용 가능한 카메라 확인
  final List<CameraDescription> cameras = await availableCameras();
  debugPrint('Available cameras: \$cameras'); // Debugging log
  runApp(MyApp(camera: cameras.first)); // 앱 실행 진입점
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building MyApp with camera: \$camera'); // Debugging log
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => GalleryPage(camera: camera),
        '/camera': (context) => TakePictureScreen(camera: camera),
      },
    );
  }
}
