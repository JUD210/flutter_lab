import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String result = '';

  onPressGet({String testMode = "default"}) async {
    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
    };

    late String uri;
    if (testMode == "error") {
      uri = 'https://vlashvlzvcv.com';
    } else if (testMode == "no_content") {
      uri = 'https://api.github.com/nonexistent_endpoint';
    } else {
      uri = 'https://jsonplaceholder.typicode.com/posts/1';
    }

    http.Response response = await http.get(Uri.parse(uri), headers: headers);
    setState(() {
      result = response.body;
    });
    if (response.statusCode == 200) {
      debugPrint('200! ok');
    } else if (response.statusCode == 204) {
      debugPrint('No Content');
    } else if (response.statusCode == 404) {
      debugPrint('Not Found');
    } else {
      debugPrint('error......');
    }
  }

  onPressPost() async {
    try {
      http.Response response = await http.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          body: {'title': 'hello', 'body': 'world', 'userId': '1'});
      debugPrint('statusCode : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          result = response.body;
        });
      } else {
        debugPrint('error......');
      }
    } catch (e) {
      debugPrint('error ... $e');
    }
  }

  onPressClient() async {
    var client = http.Client();
    try {
      http.Response response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          body: {'title': 'hello', 'body': 'world', 'userId': '1'});

      if (response.statusCode == 200 || response.statusCode == 201) {
        response = await client
            .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
        setState(() {
          result = response.body;
        });
      } else {
        debugPrint('error......');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(result),
              ElevatedButton(
                onPressed: () => onPressGet(testMode: "default"),
                child: Text('GET: default'),
              ),
              ElevatedButton(
                onPressed: () => onPressGet(testMode: "error"),
                child: Text('GET: error'),
              ),
              ElevatedButton(
                onPressed: () => onPressGet(testMode: "no_content"),
                child: Text('GET: no_content'),
              ),
              ElevatedButton(
                onPressed: onPressPost,
                child: Text('POST'),
              ),
              ElevatedButton(
                onPressed: onPressClient,
                child: Text('Client'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
