import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/data/http_data.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:http/http.dart' as http;

final groceriesProvider =
    StateNotifierProvider<GroceriesItemsProvider, List<GroceryItem>>((ref) => GroceriesItemsProvider());

class GroceriesItemsProvider extends StateNotifier<List<GroceryItem>> {
  GroceriesItemsProvider() : super(groceryItems);

  set setItems(List<GroceryItem> items) {
    state = items;
  }

  bool isLoading = false;
  String? error;

  void resetError() {
    error = null;
  }

  Future<String?> add(GroceryItem item) async {
    isLoading = true;
    error = null;
    Response response = await http.post(Uri.https(firebaseRoot, shoppingListJson),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': item.name,
          'quantity': item.quantity,
          'category': item.category.title,
        }));

    isLoading = false;

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      GroceryItem newItem = GroceryItem(
        id: data['name'],
        name: item.name,
        quantity: item.quantity,
        category: item.category,
      );

      state = [...state, newItem];
    } else {
      error = 'Failed to add item';
    }

    return error;
  }

  Future<String?> remove(GroceryItem item) async {
    final url = Uri.https(firebaseRoot, 'shopping_list/${item.id}.json');

    isLoading = true;
    error = null;

    Response response = await http.delete(url);

    isLoading = false;

    if (response.statusCode != 200) {
      error = 'Failed to remove item';
    } else {
      state = [...state.where((element) => element.id != item.id)];
    }

    return error;
  }

  void update(GroceryItem item) {
    state = [
      for (final groceryItem in state)
        if (groceryItem.id == item.id) item else groceryItem
    ];
  }

  Future<String?> loadItemsAsync() async {
    final url = Uri.https(firebaseRoot, shoppingListJson);

    isLoading = true;
    error = null;

    Response response;

    try {
      response = await http.get(url);
    } catch (e) {
      state = [];
      error = 'Failed to load items';
      return error;
    }

    isLoading = false;

    if (response.statusCode == 200) {
      final data = response.body == 'null' ? {} : json.decode(response.body) as Map<String, dynamic>;
      final List<GroceryItem> loadedItems = [];

      data.forEach((key, value) {
        loadedItems.add(
          GroceryItem(
            id: key,
            name: value['name'],
            quantity: value['quantity'],
            category: categories.entries.firstWhere((element) => element.value.title == value['category']).value,
          ),
        );
      });

      state = loadedItems;
    } else {
      state = [];
      error = 'Failed to load items';
    }

    return error;
  }
}
