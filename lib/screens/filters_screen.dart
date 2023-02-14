import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key, required this.saveFilters, required this.currentFilters}) : super(key: key);

  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;



  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var glutenFree = false;
  var vegetarian = false;
  var vegan = false;
  var lactoseFree = false;

  @override
  void initState() {
    glutenFree = widget.currentFilters['gluten']!;
    vegetarian = widget.currentFilters['vegetarian']!;
    vegan = widget.currentFilters['vegan']!;
    lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': glutenFree,
                'lactose': lactoseFree,
                'vegetarian': vegetarian,
                'vegan': vegan,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
           Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  title: const Text('Gluten-free'),
                  subtitle: const Text('Only include gluten-free meals.'),
                  value: glutenFree,
                  onChanged: (newValue) {
                    setState(() {
                      glutenFree = newValue;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Lactose-free'),
                  subtitle: const Text('Only include lactose-free meals.'),
                  value: lactoseFree,
                  onChanged: (newValue) {
                    setState(() {
                      lactoseFree = newValue;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegetarian'),
                  subtitle: const Text('Only include vegetarian meals.'),
                  value: vegetarian,
                  onChanged: (newValue) {
                    setState(() {
                      vegetarian = newValue;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Vegan'),
                  subtitle: const Text('Only include vegan meals.'),
                  value: vegan,
                  onChanged: (newValue) {
                    setState(() {
                      vegan = newValue;
                    });
                  },
                ),
              ]
            )
           ),
        ],
      ),
    );
  }
}
