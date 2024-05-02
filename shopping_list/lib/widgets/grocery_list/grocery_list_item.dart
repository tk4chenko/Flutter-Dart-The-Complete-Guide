import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/texts/text_label_medium.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem(this.groceryItem, {super.key});

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        leading: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: groceryItem.category.color,
            borderRadius: BorderRadius.circular(5),
          ),
          // my solution:
          // Icon(
          //   Icons.square,
          //   color: groceryItem.category.color,
          //   size: 30,
        ),
        title: TextLabelMedium(groceryItem.name),
        trailing: TextLabelMedium(groceryItem.quantity.toString()),
      ),
    );
  }
}
