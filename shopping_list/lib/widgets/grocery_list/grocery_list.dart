import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/providers/groceries_privider.dart';
import 'package:shopping_list/widgets/grocery_list/grocery_list_item.dart';
import 'package:shopping_list/widgets/texts/text_label_medium.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key});

  @override
  ConsumerState<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  @override
  void initState() {
    super.initState();
    ref.read(groceriesProvider.notifier).loadItemsAsync();
  }

  @override
  Widget build(BuildContext context) {
    final groceryItems = ref.watch(groceriesProvider);
    final groceryItemsNotifier = ref.read(groceriesProvider.notifier);

    return groceryItemsNotifier.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : groceryItemsNotifier.error != null
            ? Center(
                child: TextLabelMedium(groceryItemsNotifier.error!),
              )
            : groceryItems.isEmpty
                ? const Center(
                    child: TextLabelMedium('No items yet. Add some!'),
                  )
                : ListView.builder(
                    itemCount: groceryItems.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: ValueKey(groceryItems[index].id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        groceryItemsNotifier.remove(groceryItems[index]);
                      },
                      background: Container(
                        color: const Color.fromARGB(255, 255, 113, 113),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      child: GroceryListItem(groceryItems[index]),
                    ),
                  );
  }
}
