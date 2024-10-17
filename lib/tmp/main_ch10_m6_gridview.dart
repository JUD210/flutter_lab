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
          title: Text('Product Grid'),
        ),
        body: ProductGrid(),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products = ProductSamples().getProducts();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // 그리드의 각 열에 고정된 수의 항목을 배치하는 데 사용됨.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 그리드의 열 수
        crossAxisSpacing: 10.0, // 열 간의 간격
        mainAxisSpacing: 10.0, // 행 간의 간격
      ),
      itemCount: products.length, // 그리드에 표시할 항목의 총 개수
      padding: EdgeInsets.all(10.0), // 그리드의 전체 여백
      // 각 항목을 빌드하는 함수. index를 사용해 데이터를 참조.
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(products[index]['icon'], size: 50.0),
              SizedBox(height: 10.0),
              Text(
                products[index]['name'],
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              Text(
                products[index]['price'],
                style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductSamples {
  List<Map<String, dynamic>> getProducts() {
    return [
      {'name': '노트북', 'price': '₩1,200,000', 'icon': Icons.laptop},
      {'name': '스마트폰', 'price': '₩800,000', 'icon': Icons.phone_android},
      {'name': '헤드셋', 'price': '₩150,000', 'icon': Icons.headset},
      {'name': '손목시계', 'price': '₩300,000', 'icon': Icons.watch},
      {'name': '태블릿', 'price': '₩500,000', 'icon': Icons.tablet},
      {'name': 'TV', 'price': '₩1,000,000', 'icon': Icons.tv},
    ];
  }
}
