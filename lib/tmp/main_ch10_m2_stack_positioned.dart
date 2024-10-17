import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack and Positioned'),
        ),
        body: Center(
          child: Stack(
            children: [
              Container(
                width: 300,
                height: 200,
                color: Colors.blue,
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Text(
                  'Hello, Flutter!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
