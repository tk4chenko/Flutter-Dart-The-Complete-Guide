import 'package:flutter/material.dart';
import 'package:meals_app/general/extensions.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem(this.meal, this.onSelected, {super.key});

  final Meal meal;
  final Function(Meal, ImageProvider) onSelected;

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider = NetworkImage(meal.imageUrl);

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge, // prevents any ocntent inside card from overflowing
      elevation: 2,
      child: InkWell(
        onTap: () => onSelected(meal, imageProvider),
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: imageProvider,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 5,
              right: 5,
              left: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(Icons.schedule, '${meal.duration} min'),
                        const SizedBox(width: 12),
                        MealItemTrait(Icons.work, meal.complexity.name.capitalize()),
                        const SizedBox(width: 12),
                        MealItemTrait(Icons.attach_money, meal.affordability.name.capitalize()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
