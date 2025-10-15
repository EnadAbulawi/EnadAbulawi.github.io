import 'package:flutter/material.dart';

// الصفحات
import 'pages/home_page.dart';
import 'pages/app_details_page.dart';

// الثيم
import 'theme/app_theme.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const NoorApps());
}

class NoorApps extends StatelessWidget {
  const NoorApps({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with ThemeProviderWrapper to manage theme state
    return ThemeProviderWrapper(
      child: Builder(
        builder: (context) {
          // Access the ThemeProvider to get themeMode and toggleTheme
          final themeProvider = ThemeProvider.of(context);

          return MaterialApp(
            title: 'مجموعة تطبيقات نُور',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            // Use the themeMode from the provider
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/app-details': (context) => const AppDetailsPage(),
            },
          );
        },
      ),
    );
  }
}
