import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

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

  Map<Filter, bool> _selectedFilters = kInitialFilters;

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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      onSelectFavoriteMeal: _toggleFavoriteMeal,
      availableMeals: availableMeals,
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
      drawer: MainDrawer(
        onSetScreen: _setScreen,
      ),
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
