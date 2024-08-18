import 'package:flutter/material.dart';

class NewsSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;
  final Function(List<String>) onCategorySelection;
  final List<String> selectedCategories;

  NewsSearchDelegate({
    required this.onSearch,
    required this.onCategorySelection,
    required this.selectedCategories,
  });

  List<String> categoriesNames = ['General', 'Business', 'Entertainment', 'Health', 'Science', 'Sports', 'Technology'];

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [
        _buildCategorySelection(context),
        const Expanded(
          child: Center(child: Text('Suggestions')),
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return Column(
      children: [
        _buildCategorySelection(context),
        const Expanded(
          child: Center(child: Text('Results')),
        ),
      ],
    );
  }

  Widget _buildCategorySelection(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: categoriesNames.map((category) {
        final isGeneralSelected = selectedCategories.contains('General');
        final isSelected = selectedCategories.contains(category);

        return ChoiceChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (bool selected) {
            if (category == 'General') {
              if (selected) {
                onCategorySelection(['General']);
              } else {
                onCategorySelection([]);
              }
            } else {
              if (isGeneralSelected) return;
              List<String> updatedCategories = List.from(selectedCategories);
              if (selected) {
                updatedCategories.add(category);
              } else {
                updatedCategories.remove(category);
              }
              onCategorySelection(updatedCategories);
            }
          },
        );
      }).toList(),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context); // Clear the search input
        },
      ),
    ];
  }
}