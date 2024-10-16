import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page !!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('알림'),
          content: const Text('잉어! 잉어잉어!'),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 텍스트 위젯 활용하기: 잉혁킹 키우기 RPG 제목
            const Text(
              '잉혁킹 키우기 RPG',
              style: TextStyle(fontSize: 36),
            ),
            // 제스처 감지기 사용: 이미지를 탭했을 때 알림 대화상자 표시
            GestureDetector(
              onTap: _showAlertDialog,
              child: Image.asset(
                'assets/images/Shiny Magikarp 100.png',
                width: 200,
                height: 200,
              ),
            ),
            // 카운터를 표시하는 텍스트 위젯
            Text(
              '좋아요: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Hello, Flutter! 텍스트 위젯 스타일 설정
            const Text(
              'Hello, Flutter!',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            // 아이콘과 아이콘 버튼 사용하기: 하트 아이콘 추가
            IconButton(
              icon: const Icon(FontAwesomeIcons.heart),
              color: Colors.pink,
              onPressed: () {
                print('Heart icon clicked!');
              },
            ),
            // 엘리베이트 버튼 사용하기
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: const Text('Elevated Button'),
            ),
            // 컨테이너와 센터 위젯 사용하기: 둥근 모서리의 박스 생성
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text(
                  '둥근 모서리 박스 안',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
