import 'package:flutter/material.dart';
import '../models/meals_model.dart';
import '../widgets/meal_items_widget.dart';

class CategoryItemsScreen extends StatefulWidget {
  static const routeName = '/categories';

  const CategoryItemsScreen({super.key, required this.availableMeals});

  final List<MealsModel> availableMeals;

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  String title = '';
  List<MealsModel> categoryMeals = [];
  var _loadedInitData = false;

  @override
  void initState() {
    //..
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      title = routeArgs['title']! as String;
      final categoryId = routeArgs['id']! as String;
      categoryMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItems(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability,
            );
          },
          itemCount: categoryMeals.length),
    );
  }
}
