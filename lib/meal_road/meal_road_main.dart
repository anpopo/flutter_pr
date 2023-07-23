
import 'package:first_web/meal_road/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.alkatraTextTheme(),
);

void main () {
  runApp(const MealRoadApp());
}

class MealRoadApp extends StatelessWidget {
  const MealRoadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const CategoryScreen(),
    );
  }

}