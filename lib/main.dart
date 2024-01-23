import 'package:flutter/material.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import './screens/categories_meals_screen.dart';
import './utils/app_routes.dart';
import './screens/tabs_screen.dart';
import './screens/settings_screen.dart';
import './models/meal.dart';
import './models/settings.dart';
import './data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];
  Settings settings = Settings();

  void _filterMeals(Settings settings) {
    setState(
      () {
        this.settings = settings;
        _availableMeals = dummyMeals.where(
          (meal) {
            final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
            final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
            final filterVegan = settings.isVegan && !meal.isVegan;
            final filterVegetarian =
                settings.isVegetarian && !meal.isVegetarian;
            return !filterGluten &&
                !filterLactose &&
                !filterVegan &&
                !filterVegetarian;
          },
        ).toList();
      },
    );
  }

  void _toggleFavorites(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      title: 'DeliMeals',
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
            primary: Colors.pink,
            secondary: Colors.amber,
            background: Color.fromRGBO(255, 254, 229, 1)),
        textTheme: tema.textTheme.copyWith(
          bodyLarge: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 18,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'RobotoCondensed',
          ),
        ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(
              meals: _availableMeals,
            ),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(
            onToggleFavorite: _toggleFavorites, isFavorite: _isFavorite),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(
              onSettingsChanged: _filterMeals,
              settings: settings,
            ),
      },
      onUnknownRoute: (_) {
        return MaterialPageRoute(builder: (_) {
          return CategoriesScreen();
        });
      },
    );
  }
}
