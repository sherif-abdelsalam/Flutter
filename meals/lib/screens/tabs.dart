import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _activeScreenIndex = 0;
  String screenTitle = "Categories";

  void _selectScreen(int index) {
    setState(
      () {
        _activeScreenIndex = index;
        if (index == 1) {
          screenTitle = "Your Favorites";
        } else {
          screenTitle = "Categories";
        }
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Center(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  final List<Meal> _favoriteMeals = [];
  void _toggleFavoriteMeal(Meal meal) {
    var isExisted = _favoriteMeals.contains(meal);
    if (isExisted) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showSnackBar("Meal removed from favorites 😴");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showSnackBar("Meal added to favorites 😋");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onSelectFavoriteMeal: _toggleFavoriteMeal,
    );
    if (_activeScreenIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        onSelectFavoriteMeal: _toggleFavoriteMeal,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: _activeScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
