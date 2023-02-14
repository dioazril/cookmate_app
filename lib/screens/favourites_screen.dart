import 'package:flutter/material.dart';
import '../models/meals_model.dart';
import '../widgets/meal_items_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key, required this.favouriteMeals})
      : super(key: key);

  final List<MealsModel> favouriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
          itemBuilder: (context, index) {
            return MealItems(
              id: favouriteMeals[index].id,
              title: favouriteMeals[index].title,
              imageUrl: favouriteMeals[index].imageUrl,
              duration: favouriteMeals[index].duration,
              complexity: favouriteMeals[index].complexity,
              affordability: favouriteMeals[index].affordability,
            );
          },
          itemCount: favouriteMeals.length);
    }
  }
}
