import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(this.meals, this.onToggleFavorite, {super.key, this.title});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void Function(Meal, ImageProvider) onSelected(BuildContext context) => (meal, imageProvider) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MealDetailsScreen(meal, imageProvider, onToggleFavorite)));
      };

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isNotEmpty
        ? ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              return MealItem(meals[index], onSelected(context));
            },
          )
        : Card(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No meals found.',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Try selecting different category',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            ),
          );

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
