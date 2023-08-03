import 'package:first_web/meal_road/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = Provider((ref) => dummyMeals);
