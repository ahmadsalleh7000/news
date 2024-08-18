import 'package:flutter/material.dart';

class ApplicationDrawer extends StatelessWidget implements PreferredSizeWidget {
  const ApplicationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'News App!',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 24,
                  fontWeight: FontWeight.bold, // Styling text
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                'Categories',
                style: TextStyle(
                  color: Colors.black87, // Text color
                  fontWeight: FontWeight.w600, // Text weight
                  fontSize: 20, // Font size
                ),
              ),
              leading: const Icon(
                Icons.list,
                color: Colors.black, // Icon color
                size: 28, // Icon size
              ),
              onTap: () {
                // Navigate to categories screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/categories');
              },
              tileColor: Colors.grey[200], // Background color of tile
              shape: RoundedRectangleBorder( // Custom shape
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20,), // Padding
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 28,
              ),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
              tileColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
