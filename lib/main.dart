import 'package:flutter/material.dart';
import 'home_page.dart';
import 'bag_page.dart';
import 'favorites_page.dart';
import 'profile_page.dart';
import 'hop_page.dart'; // Import HopPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2; // Set default index to 2 for HopPage

  // Initialize the pages including HopPage in the middle.
  final List<Widget> _pages = [
    HomePage(),
    BagPage(),
    HopPage(), // HopPage in the middle
    FavoritesPage(),
    ProfilePage(),
  ];

  final List<Color> _iconColors = [
    Colors.red, // Home icon color
    Colors.blue, // Bag icon color
    Colors.green, // Hop icon color
    Colors.orange, // Favorites icon color
    Colors.purple, // Profile icon color
  ];

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
        items: List.generate(5, (index) {
          return BottomNavigationBarItem(
            icon: Icon(
              _getIconForIndex(index),
              color: _selectedIndex == index ? _iconColors[index] : Colors.grey,
            ),
            label: _getLabelForIndex(index),
          );
        }),
        currentIndex: _selectedIndex,
        selectedItemColor: _iconColors[
            _selectedIndex], // Icon and label color for selected item
        unselectedItemColor:
            Colors.grey, // Icon and label color for unselected items
        onTap: _onItemTapped,
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.shopping_bag;
      case 2:
        return Icons.local_cafe; // Icon for HopPage
      case 3:
        return Icons.favorite;
      case 4:
        return Icons.person;
      default:
        return Icons.home;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Bag';
      case 2:
        return 'Hop';
      case 3:
        return 'Favorites';
      case 4:
        return 'Profile';
      default:
        return 'Home';
    }
  }
}
