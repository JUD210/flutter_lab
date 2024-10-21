import 'package:flutter/material.dart';
import 'recipe.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('레시피 목록'),
      ),
      body: ListView.builder(
        itemCount: recipeSamples.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(recipeSamples[index].foodName),
              subtitle: Text(recipeSamples[index].description),
              onTap: () async {
                final tmpRating = await Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: recipeSamples[index],
                );
                debugPrint('tmp_rating: $tmpRating');
              },
            ),
          );
        },
      ),
    );
  }
}
