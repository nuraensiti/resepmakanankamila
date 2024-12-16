//punya kamila kp.herlambang@gmail.com
import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const RecipeVaultApp());
}

class RecipeVaultApp extends StatelessWidget {
  const RecipeVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RecipeVault - Kamila',
      theme: ThemeData(
        primaryColor: Color(0xFFFFB200),
        dialogBackgroundColor: Color(0xFFE4003A),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
    );
  }
}
