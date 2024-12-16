//punya kamila kp.herlambang@gmail.com

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  String? _imagePath;
  List<Map<String, String>> _recipeList = [];

  void _submitRecipe() {
    final name = _nameController.text.trim();
    final ingredients = _ingredientsController.text.trim();

    if (name.isNotEmpty && ingredients.isNotEmpty && _imagePath != null) {
      _recipeList.add({
        'name': name,
        'ingredients': ingredients,
        'imagePath': _imagePath!,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe "$name" added successfully!'),
          backgroundColor: Colors.teal,
        ),
      );
      _nameController.clear();
      _ingredientsController.clear();
      setState(() {
        _imagePath = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imagePath = pickedFile?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
        centerTitle: true,
        backgroundColor: Color(0xFFE4003A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recipe Name:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter recipe name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _ingredientsController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter ingredients',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE4003A),
              ),
            ),
            if (_imagePath != null)
              Image.file(File(_imagePath!), height: 150),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: _submitRecipe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 12.0,
                  ),
                ),
                child: const Text('Submit Recipe'),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
