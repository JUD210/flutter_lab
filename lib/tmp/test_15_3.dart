import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String result = '';

  dioTest() async {
    try {
      // 교재 코드에서는 5000만 제공하지만, 그러면 다음과 같은 에러가 뜸.
      // Error: The argument type 'int' can't be assigned to the parameter type 'Duration?'.
      //  - 'Duration' is from 'dart:core'.
      // Dio 인스턴스를 생성하고, 기본 설정(기본 URL, 타임아웃, 헤더 등)을 적용함.
      var dio = Dio(BaseOptions(
        baseUrl: "https://reqres.in/api/",
        connectTimeout: Duration(milliseconds: 5000),
        receiveTimeout: Duration(milliseconds: 5000),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
      ));

      // Adding an interceptor to log requests and responses
      // 요청, 응답, 오류를 로깅하기 위해 인터셉터를 추가함.
      // 인터셉터 레퍼를 활용하면, 굳이 Interceptor 상속받은 클래스를 만들 필요가 없음.
      dio.interceptors.add(InterceptorsWrapper(
        // onRequest는 요청이 보내지기 전에 호출됨.
        // 여기서 요청에 대한 추가 정보나 수정 작업을 수행할 수 있음.
        onRequest: (options, handler) {
          debugPrint('⚠️ Request[${options.method}] => PATH: ${options.path}');
          // ⚠️ Request[GET] => PATH: https://reqres.in/api/users?page=1

          return handler.next(options); // 요청을 계속 진행함.
        },
        // onResponse는 응답을 받은 후 호출됨.
        // 응답 데이터를 로깅하거나 확인하는 데 유용함.
        onResponse: (response, handler) {
          debugPrint(
              '️⚠️ Response[${response.statusCode}] => DATA: ${response.data}');
          // ⚠️ Request[GET] => PATH: https://reqres.in/api/users?page=2

          return handler.next(response); // 응답을 계속 진행함.
        },
        // onError는 오류가 발생했을 때 호출됨.
        // 오류 세부 정보를 로깅하거나 오류 처리를 수행하는 데 사용할 수 있음.
        // 'DioError' is deprecated and shouldn't be used. Use DioException instead. This will be removed in 6.0.0. (Documentation)
        // 그러므로, DioError -> DioException 변경.
        onError: (DioException e, handler) {
          debugPrint(
              '⚠️ Error[${e.response?.statusCode}] => MESSAGE: ${e.message}');
          // ⚠️ Response[200] => DATA: {page: 1, per_page: 6, total: 12, total_pages: 2, data: [{id: 1, email: george.bluth@reqres.in, first_name: George, last_name: Bluth, avatar: https://reqres.in/img/faces/1-image.jpg}, {id: 2, email: janet.weaver@reqres.in, first_name: Janet, last_name: Weaver, avatar: https://reqres.in/img/faces/2-image.jpg}, {id: 3, email: emma.wong@reqres.in, first_name: Emma, last_name: Wong, avatar: https://reqres.in/img/faces/3-image.jpg}, {id: 4, email: eve.holt@reqres.in, first_name: Eve, last_name: Holt, avatar: https://reqres.in/img/faces/4-image.jpg}, {id: 5, email: charles.morris@reqres.in, first_name: Charles, last_name: Morris, avatar: https://reqres.in/img/faces/5-image.jpg}, {id: 6, email: tracey.ramos@reqres.in, first_name: Tracey, last_name: Ramos, avatar: https://reqres.in/img/faces/6-image.jpg}], support: {url: https://reqres.in/#support-heading, text: To keep ReqRes free, contributions towards server costs are appreciated!}}

          return handler.next(e); // 오류 처리를 계속 진행함.
        },
      ));

      List<Response<dynamic>> response = await Future.wait([
        dio.get('https://reqres.in/api/users?page=1'),
        dio.get('https://reqres.in/api/users?page=2')
      ]);

      // response.forEach((element) {
      for (var element in response) {
        if (element.statusCode == 200) {
          setState(() {
            result = element.data.toString();
          });
        }
      }
    } catch (e) {
      debugPrint(e as String?);
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
                onPressed: dioTest,
                child: Text('Get Server Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
