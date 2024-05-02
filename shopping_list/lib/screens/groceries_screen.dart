import 'package:flutter/material.dart';
import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/widgets/grocery_list/grocery_list.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  void _addGroceryItem(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NewItem()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addGroceryItem(context),
          ),
        ],
      ),
      body: const Center(
        child: GroceryList(),
      ),
    );
  }
}
