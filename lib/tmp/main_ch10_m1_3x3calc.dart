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
          title: Text('3x3 계산기'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('7'),
                  SizedBox(width: 10),
                  _buildButton('8'),
                  SizedBox(width: 10),
                  _buildButton('9'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('4'),
                  SizedBox(width: 10),
                  _buildButton('5'),
                  SizedBox(width: 10),
                  _buildButton('6'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('1'),
                  SizedBox(width: 10),
                  _buildButton('2'),
                  SizedBox(width: 10),
                  _buildButton('3'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildButton(String label) {
  return Container(
    width: 80,
    height: 80,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    ),
  );
}
