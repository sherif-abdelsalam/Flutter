import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meal_provider.dart';

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if ((filters[Filter.glutenFree]! && !meal.isGlutenFree) ||
        (filters[Filter.lactoseFree]! && !meal.isLactoseFree) ||
        filters[Filter.vegetarian]! && !meal.isVegetarian ||
        (filters[Filter.vegan]! && !meal.isVegan)) {
      return false;
    }
    return true;
  }).toList();
});
