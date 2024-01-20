import 'package:flutter/material.dart';
import './screens/categories_screen.dart';
import './screens/categories_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: CategoriesScreen(),
      routes: {'/categories-meals': (ctx) => CategoriesMealsScreen()},
    );
  }
}
