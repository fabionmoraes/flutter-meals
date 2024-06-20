import 'package:flutter/material.dart';
import 'package:meals/models/settings.dart';

import 'screens/categories/meals.dart';
import 'screens/categories/detail.dart';
import 'screens/tabs.dart';
import 'screens/settings.dart';

import 'utils/app_routes.dart';

import 'models/meal.dart';
import 'data/dummy_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = dummyMeals;

  void _filterMeals(Settings settings) {
    setState(() {
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      title: 'DeliMeals',
      theme: theme.copyWith(
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          // bodyMedium: const TextStyle(fontFamily: 'Raleway'),
          titleMedium: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromRGBO(255, 254, 229, 1),
        ),
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(255, 254, 229, 1),
        cardTheme: theme.cardTheme.copyWith(
          color: Colors.white,
        ),
      ),
      routes: {
        AppRoutes.home: (_) => const TabsScreen(),
        AppRoutes.categoriesMeals: (_) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.mealDetail: (_) => const MealDetailScreen(),
        AppRoutes.settings: (_) => SettingsScreen(_filterMeals),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            return const TabsScreen();
          },
        );
      },
    );
  }
}
