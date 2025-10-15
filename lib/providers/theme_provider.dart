import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends InheritedWidget {
  final ThemeMode themeMode;
  final Function(bool isDark) toggleTheme;

  const ThemeProvider({
    Key? key,
    required this.themeMode,
    required this.toggleTheme,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeProvider of(BuildContext context) {
    final ThemeProvider? result = context
        .dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(result != null, 'No ThemeProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeMode != oldWidget.themeMode;
  }

  // factory ThemeProvider({Key? key, required Widget child}) {
  //   return _ThemeProviderWrapper(key: key, child: child);
  // }
}

class ThemeProviderWrapper extends StatefulWidget {
  final Widget child;

  const ThemeProviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<ThemeProviderWrapper> createState() => _ThemeProviderWrapperState();
}

class _ThemeProviderWrapperState extends State<ThemeProviderWrapper> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDarkMode');
      if (isDark != null) {
        setState(() {
          _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
        });
      }
    } catch (e) {
      debugPrint('Error loading theme: $e');
    }
  }

  Future<void> _toggleTheme(bool isDark) async {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', isDark);
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeMode: _themeMode,
      toggleTheme: _toggleTheme,
      child: widget.child,
    );
  }
}
