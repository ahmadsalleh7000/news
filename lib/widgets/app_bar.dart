import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:news/widgets/search_delegate.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatefulWidget implements PreferredSizeWidget {
  const ApplicationBar({super.key});

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _ApplicationBarState extends State<ApplicationBar> {
  List<String> categoriesNames = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  List<String> selectedCategories = ['General'];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SettingsProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return AppBar(
      title: const Text('Top News'),
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_4),
          onPressed: () {
            setState(() {
              isDarkMode
                  ? themeProvider.setDarkMode(false)
                  : themeProvider.setDarkMode(true);
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: NewsSearchDelegate(
                onSearch: (query) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Provider.of<NewsProvider>(context, listen: false)
                        .setSearchKeyword(query);
                    // Trigger category-based search after selection
                    Provider.of<NewsProvider>(context, listen: false)
                        .setCategories(selectedCategories);

                                          Navigator.pop(context);
                  });

                },
                onCategorySelection: _onCategorySelection,
                selectedCategories: selectedCategories,
              ),
            );
          },
        ),
      ],
    );
  }

  void _onCategorySelection(List<String> selectedCategories) {
    setState(() {
      this.selectedCategories = selectedCategories;
    });
  }
}