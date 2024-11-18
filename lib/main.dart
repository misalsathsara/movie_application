import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true; // Set default theme to dark

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        onThemeChanged: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}