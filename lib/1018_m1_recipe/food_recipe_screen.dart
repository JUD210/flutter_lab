import 'package:flutter/material.dart';
import 'recipe.dart';

class FoodRecipeScreen extends StatefulWidget {
  const FoodRecipeScreen({super.key});

  @override
  _FoodRecipeScreenState createState() => _FoodRecipeScreenState();
}

class _FoodRecipeScreenState extends State<FoodRecipeScreen> {
  double _tmpRating = 0.0; // 초기 별점 값

  @override
  Widget build(BuildContext context) {
    Recipe recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.foodName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.description,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  recipe.cookGuide.map((String step) => Text(step)).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              '이 레시피에 대한 별점을 매겨주세요:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _tmpRating,
              min: 0,
              max: 5,
              divisions: 10,
              label: _tmpRating.toString(),
              onChanged: (double value) {
                setState(() {
                  _tmpRating = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 이전 화면으로 별점 데이터를 전달하면서 되돌아감

                // Todo Later: 별점 데이터를 Recipe 객체로 전송하는 코드를 추가해보자.
                // recipe.rating = _rating;
                // debugPring('recipe.rating: ${recipe.rating}');
                Navigator.pop(context, _tmpRating);
              },
              child: const Text('별점 제출'),
            ),
          ],
        ),
      ),
    );
  }
}
