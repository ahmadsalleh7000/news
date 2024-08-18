import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
   final String title;
   final bool isSelected;

  const TabItem({super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: isSelected ? null : Border.all(color: Colors.green, width: 2.0),
        boxShadow: isSelected ? [BoxShadow(color: Theme.of(context).primaryColor, blurRadius: 4.0)] : null,
      ),
        padding: const EdgeInsets.all(8.0), 
        child: Tab(child: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.grey),),)
        );
  }
}