import 'package:flutter/material.dart';
import 'package:news/providers/settings_provider.dart';
import 'package:news/screens/pattern_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Language Card
            Card(
              child: ListTile(
                title: const Text('Language'),
                subtitle: Text(settingsProvider.isArabic ? 'Arabic' : 'English'),
                trailing: Switch(
                  value: settingsProvider.isArabic,
                  onChanged: (value) {
                    settingsProvider.setArabic(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Theme Mode Card
            Card(
              child: ListTile(
                title: const Text('Theme Mode'),
                subtitle: Text(settingsProvider.isDarkMode ? 'Dark Mode' : 'Light Mode'),
                trailing: Switch(
                  value: settingsProvider.isDarkMode,
                  onChanged: (value) {
                    settingsProvider.setDarkMode(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // App Lock Enabled Card
            Card(
              child: ListTile(
                title: const Text('App Lock'),
                subtitle: Text(settingsProvider.isAppLockEnabled ? 'Enabled' : 'Disabled'),
                trailing: Switch(
                  value: settingsProvider.isAppLockEnabled,
                  onChanged: (value) {
                    settingsProvider.setAppLockEnabled(value);
                    if (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPatternScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Lock Type Card (only shown if app lock is enabled)
            if (settingsProvider.isAppLockEnabled)
              Card(
                child: ListTile(
                  title: const Text('Lock Type'),
                  subtitle: Text(settingsProvider.appLockType),
                  trailing: DropdownButton<String>(
                    value: settingsProvider.appLockType,
                    onChanged: (value) {
                      if (value != null) {
                        settingsProvider.setAppLockType(value);
                      }
                    },
                    items: <String>['None', 'Fingerprint', 'PIN', 'Pattern']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
