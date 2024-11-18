import 'package:flutter/material.dart';
import 'package:movie_application/model/movie.dart';

class CustomDrawer extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const CustomDrawer({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkMode, required List<Movie> favorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35),
                ),
                SizedBox(height: 10),
                Text(
                  'Movie App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Downloads'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            secondary: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            value: isDarkMode,
            onChanged: onThemeChanged,
          ),
        ],
      ),
    );
  }
}