//punya kamila kp.herlambang@gmail.com
import 'package:flutter/material.dart';
import 'add_recipe_page.dart';

class RecipeListPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteRecipes;

  const RecipeListPage({super.key, required this.favoriteRecipes});

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  final List<Map<String, dynamic>> recipes = [
    {
      'name': 'Spaghetti Carbonara',
      'image': 'assets/spaghetti.jpg',
      'description': 'Delicious spaghetti with creamy sauce.',
      'instructions': '1. Boil spaghetti. 2. Cook bacon. 3. Mix with sauce.',
      'likes': 0,
      'isFavorite': false,
    },
    {
      'name': 'Chicken Curry',
      'image': 'assets/curry.jpg',
      'description': 'Spicy chicken curry with rice.',
      'instructions': '1. Fry onions. 2. Add chicken. 3. Add spices and simmer.',
      'likes': 0,
      'isFavorite': false,
    },
    {
      'name': 'Vegetable Stir Fry',
      'image': 'assets/mieayam.jpg',
      'description': 'Healthy stir-fried vegetables.',
      'instructions': '1. Chop vegetables. 2. Stir fry in oil. 3. Serve hot.',
      'likes': 0,
      'isFavorite': false,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      recipes[index]['isFavorite'] = !recipes[index]['isFavorite'];
      if (recipes[index]['isFavorite']) {
        print('Adding to favorites: ${recipes[index]}');
        widget.favoriteRecipes.add(recipes[index]);
        recipes[index]['likes']++;
      } else {
        print('Removing from favorites: ${recipes[index]}');
        widget.favoriteRecipes.removeWhere((recipe) => recipe['name'] == recipes[index]['name']);
        recipes[index]['likes']--;
      }
    });
  }

  void _deleteRecipe(int index) {
    setState(() {
      widget.favoriteRecipes.removeWhere((recipe) => recipe['name'] == recipes[index]['name']);
      recipes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        centerTitle: true,
        backgroundColor: Color(0xFFE4003A),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddRecipePage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(recipes[index]['name']),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            onDismissed: (direction) {
              _deleteRecipe(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${recipes[index]['name']} dihapus')),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(12.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    recipes[index]['image']!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  recipes[index]['name']!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text('${recipes[index]['likes']} Like${recipes[index]['likes'] == 1 ? '' : 's'}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        recipes[index]['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                        color: recipes[index]['isFavorite'] ? Colors.red : null,
                      ),
                      onPressed: () => _toggleFavorite(index),
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      child: Text(
                        '${recipes[index]['likes']} Likes',
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  _showRecipeDialog(context, recipes[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showRecipeDialog(BuildContext context, Map<String, dynamic> recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(recipe['name']!),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(recipe['image']!),
                  SizedBox(height: 10),
                  Text(recipe['description']!),
                  SizedBox(height: 10),
                  Text('Instructions:'),
                  Text(recipe['instructions']!),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}