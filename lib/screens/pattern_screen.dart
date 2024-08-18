// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SetPatternScreen extends StatefulWidget {
  const SetPatternScreen({super.key});

  @override
  State<SetPatternScreen> createState() => _SetPatternScreenState();
}

class _SetPatternScreenState extends State<SetPatternScreen> {
  String _pattern = '';
  String _confirmPattern = '';

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Set Lock Pattern')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Placeholder for pattern input UI
            // In practice, replace this with your pattern drawing UI
            TextField(
              decoration: const InputDecoration(labelText: 'Enter pattern'),
              onChanged: (value) {
                setState(() {
                  _pattern = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Confirm pattern'),
              onChanged: (value) {
                setState(() {
                  _confirmPattern = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_pattern == _confirmPattern) {
                 // await settingsProvider.setPattern(_pattern);
                  Navigator.pop(context);
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Patterns do not match')),
                  );
                }
              },
              child: const Text('Save Pattern'),
            ),
          ],
        ),
      ),
    );
  }
}
