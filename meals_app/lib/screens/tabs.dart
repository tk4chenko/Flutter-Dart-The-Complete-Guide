import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const Map<Filter, bool> defaultFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  Map<Filter, bool> _filters = defaultFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleMealFavorite(Meal meal) => setState(() {
        final isExisting = _favoriteMeals.contains(meal);

        if (isExisting) {
          setState(() {
            _showInfoMessage('Removed ${meal.title} from favorites');
            _favoriteMeals.remove(meal);
          });
        } else {
          setState(() {
            _showInfoMessage('Added ${meal.title} to favorites');
            _favoriteMeals.add(meal);
          });
        }
      });

  void _selectPage(int index) => setState(() {
        _selectedPageIndex = index;
      });

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (context) => FiltersScreen(_filters),
      ));

      setState(() {
        _filters = result ?? defaultFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String activePageTitle = 'Categories';

    final List<Meal> availableMeals = dummyMeals.where((meal) {
      if (_filters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
      if (_filters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
      if (_filters[Filter.vegetarian]! && !meal.isVegetarian) return false;
      if (_filters[Filter.vegan]! && !meal.isVegan) return false;

      return true;
    }).toList();

    Widget activePage = CategoriesScreen(availableMeals, _toggleMealFavorite);

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your Favorites';
      activePage = MealsScreen(_favoriteMeals, _toggleMealFavorite);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(activePageTitle),
        ),
        drawer: MainDrawer(_setScreen),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ));
  }
}
