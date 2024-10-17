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
          title: Text('Todo List'),
        ),
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  TodoListState createState() => TodoListState();
}

final List<Map<String, dynamic>> todoSamples = [
  {'title': '아침 운동하기', 'isDone': false},
  {'title': '설거지하기', 'isDone': false},
  {'title': '업무 이메일 확인하기', 'isDone': false},
  {'title': '점심 메뉴 정하기', 'isDone': false},
  {'title': '친구에게 전화하기', 'isDone': false},
  {'title': '서류 정리하기', 'isDone': false},
  {'title': '저녁 산책하기', 'isDone': false},
  {'title': '책 30분 읽기', 'isDone': false},
  {'title': '저녁 식사 준비하기', 'isDone': false},
  {'title': '하루 일과 정리하기', 'isDone': false},
];

class TodoListState extends State<TodoList> {
  List<Map<String, dynamic>> todos = List.from(todoSamples);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Checkbox(
            value: todos[index]['isDone'],
            onChanged: (bool? value) {
              setState(() {
                todos[index]['isDone'] = value;
              });
            },
          ),
          title: Text(todos[index]['title']),
          onTap: () {
            print('항목 세부 정보: ${todos[index]['title']}');
          },
        );
      },
    );
  }
}
