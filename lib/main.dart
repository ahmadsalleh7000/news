import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:news/screens/home_screen.dart';
import 'package:news/screens/news_categories.dart';
import 'package:news/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  bool isArabic = prefs.getBool('isArabic') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MyApp(isDarkMode: isDarkMode, isArabic: isArabic),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  final bool isArabic;

  const MyApp({super.key, required this.isDarkMode, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App',
          theme: settingsProvider.isDarkMode
              ? ThemeData.dark()
              : ThemeData.light(),
          locale: settingsProvider.isArabic ? const Locale('ar') : const Locale('en'),
          home: NewsCategories(),
          routes: {
            '/news': (context) => const HomeScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/categories': (context) =>  NewsCategories(),
          },
        );
      },
    );
  }
}
