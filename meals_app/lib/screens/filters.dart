import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this.filters, {super.key});

  final Map<Filter, bool> filters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFreeFilterSet = false;
  bool _isLactoseFreeFilterSet = false;
  bool _isVegetarianFilterSet = false;
  bool _isVeganFilterSet = false;

  @override
  void initState() {
    _isGlutenFreeFilterSet = widget.filters[Filter.glutenFree]!;
    _isLactoseFreeFilterSet = widget.filters[Filter.lactoseFree]!;
    _isVegetarianFilterSet = widget.filters[Filter.vegetarian]!;
    _isVeganFilterSet = widget.filters[Filter.vegan]!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      // drawer: MainDrawer((identifier) {
      //   Navigator.of(context).pop();

      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (context) => const TabsScreen(),
      //     ));
      //   }
      // }),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFreeFilterSet,
            Filter.lactoseFree: _isLactoseFreeFilterSet,
            Filter.vegetarian: _isVegetarianFilterSet,
            Filter.vegan: _isVeganFilterSet,
          });

          return false;
        },
        child: Column(children: [
          SwitchListTile(
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: _isGlutenFreeFilterSet,
              onChanged: (value) {
                setState(() {
                  _isGlutenFreeFilterSet = value;
                });
              }),
          SwitchListTile(
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: _isLactoseFreeFilterSet,
              onChanged: (value) {
                setState(() {
                  _isLactoseFreeFilterSet = value;
                });
              }),
          SwitchListTile(
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: _isVegetarianFilterSet,
              onChanged: (value) {
                setState(() {
                  _isVegetarianFilterSet = value;
                });
              }),
          SwitchListTile(
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: _isVeganFilterSet,
              onChanged: (value) {
                setState(() {
                  _isVeganFilterSet = value;
                });
              }),
        ]),
      ),
    );
  }
}
