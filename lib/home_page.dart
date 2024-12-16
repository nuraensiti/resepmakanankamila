//punya kamila kp.herlambang@gmail.com
import 'package:flutter/material.dart';
import 'recipe_list_page.dart';
import 'favorite_recipes_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar resep favorit yang akan dibagikan ke halaman resep dan halaman favorit
  List<Map<String, dynamic>> favoriteRecipes = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.add(_buildHomePage()); // Halaman Beranda
    _pages.add(FavoriteRecipesPage(favoriteRecipes: favoriteRecipes)); // Halaman Favorit
    _pages.add(RecipeListPage(favoriteRecipes: favoriteRecipes)); // Halaman Resep
  }

  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Ganti dengan logo aplikasi
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Recipe App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFE4003A), // Ganti dengan warna merah muda
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Recipe App!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFB200), // Ganti dengan warna kuning cerah
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Discover delicious recipes and share your favorites!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal.shade600,
                ),
              ),
              const SizedBox(height: 40),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/mieayam.jpg'), // Ganti dengan gambar menarik
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Aksi ketika tombol ditekan
                    _selectedIndex = 2;  // Navigasi ke halaman resep
                  });
                },
                child: const Text(
                  'Explore Recipes',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Color(0xFFE4003A), // Ganti dengan warna merah muda
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Recipes',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFFE4003A), // Ganti dengan warna merah muda
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
    );
  }
}
