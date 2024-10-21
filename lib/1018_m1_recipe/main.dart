import 'package:flutter/material.dart';
import 'food_list_screen.dart';
import 'food_recipe_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/list',
      routes: {
        '/list': (context) => FoodListScreen(),
        '/detail': (context) => FoodRecipeScreen(),
        // '/three': (context) => ThreeScreen(),
        // '/four': (context) => FourScreen()
      },
    );
  }
}
