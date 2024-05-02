import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/providers/groceries_privider.dart';

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key});

  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  final _formKey = GlobalKey<FormState>();

  var _enteredName = '';
  var _enteredQuantity = 1;
  var _enteredCategory = categories[Categories.vegetables]!;

  void _saveItem(GroceriesItemsProvider groceriesItemsProvider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var error = await groceriesItemsProvider.add(
        GroceryItem(
          id: DateTime.now().toString(),
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _enteredCategory,
        ),
      );

      if (error == null) {
        if (!context.mounted) {
          return;
        }

        Navigator.of(context).pop();
        return;
      } else {
        print('failed to add item');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final groceryItems = ref.read(groceriesProvider.notifier);

    bool isSending = groceryItems.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.trim().length <= 1 || value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }

                    return null;
                  },
                  onSaved: (newValue) => _enteredName = newValue!,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: '1',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be more than 1.';
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                        onSaved: (newValue) => _enteredQuantity = int.parse(newValue!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField(
                        onChanged: (value) => setState(() {
                          _enteredCategory = value as Category;
                        }),
                        value: _enteredCategory,
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                      color: category.value.color,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(category.value.title),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: isSending
                          ? null
                          : () {
                              _formKey.currentState!.reset();
                            },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: isSending ? null : () => _saveItem(groceryItems),
                      child: isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Add Item'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
