//punya kamila kp.herlambang@gmail.com
import 'package:flutter/material.dart';

class FavoriteRecipesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteRecipes;

  const FavoriteRecipesPage({super.key, required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
        centerTitle: true,
        backgroundColor: Color(0xFFE4003A),
      ),
      body: favoriteRecipes.isEmpty
          ? Center(child: Text('No favorite recipes yet.'))
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(12.0),
                  elevation: 4.0,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        favoriteRecipes[index]['image']!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(favoriteRecipes[index]['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(favoriteRecipes[index]['description']!),
                        const SizedBox(height: 5),
                        Text('${favoriteRecipes[index]['likes']} Like${favoriteRecipes[index]['likes'] == 1 ? '' : 's'}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}