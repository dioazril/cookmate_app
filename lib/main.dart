import 'package:cookmate/screens/filters_screen.dart';
import 'package:cookmate/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/meals_data.dart';
import 'models/meals_model.dart';
import 'screens/categories_screen.dart';
import 'screens/category_items_screen.dart';
import 'screens/meal_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<MealsModel> _availableMeals = mealsData;
  List<MealsModel> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = mealsData.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(
          mealsData.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFF99417),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF5),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color(0xFF3E3939),
              ),
              bodyMedium: const TextStyle(
                color: Color(0xFF3E3939),
              ),
              titleSmall: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: 25,
                fontFamily: GoogleFonts.robotoCondensed().fontFamily,
              ),
              titleMedium: TextStyle(
                color: const Color(0xFF222222),
                fontSize: 22,
                fontFamily: GoogleFonts.robotoCondensed().fontFamily,
              ),
              titleLarge: TextStyle(
                color: const Color(0xFFFFFBF5),
                fontSize: 25,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(
            const Color(0xFFF99417),
          ),
          trackColor: MaterialStateProperty.all(
            const Color(0xFFFFD8A2),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabScreen(
              favouriteMeals: _favouriteMeals,
            ),
        CategoryItemsScreen.routeName: (context) => CategoryItemsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
            toggleFavourite: _toggleFavourite,
            isMealFavourite: isMealFavourite),
        FiltersScreen.routeName: (context) => FiltersScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );
      },
    );
  }
}
