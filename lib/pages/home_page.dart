import 'package:flutter/material.dart';
import 'package:noor_apps/models/app_data.dart';
import 'package:noor_apps/pages/developer_page.dart';
import 'package:noor_apps/providers/theme_provider.dart';
import 'package:noor_apps/widgets/animated_background_widget.dart';
import 'package:noor_apps/widgets/app_card_widget.dart';
import 'package:noor_apps/widgets/social_section_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late List<AppData> apps;

  @override
  void initState() {
    super.initState();
    apps = AppData.getAllApps();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    // Determine isDark based on the themeProvider's current themeMode
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      body: AnimatedBackgroundWidget(
        isDark: isDark,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(isDark, themeProvider),
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 40),
                      _buildAppsGrid(isDark),
                      const SizedBox(height: 60),
                      SocialSectionWidget(isDark: isDark),
                      const SizedBox(height: 40),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(bool isDark, ThemeProvider themeProvider) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0,

      actions: [
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.person, color: Colors.white, size: 24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeveloperPage()),
              );
            },
            tooltip: 'معلومات المطور',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () => themeProvider.toggleTheme(!isDark),
              tooltip: isDark ? 'الوضع الفاتح' : 'الوضع المظلم',
            ),
          ),
        ),
        Spacer(),

        Text(
          'مجموعة تطبيقات نُور',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black26,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        Spacer(),
        const SizedBox(width: 10),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 800),
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/noorappswithoutbg.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   colors: app.gradientColors,
                          // ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.apps,
                          size: 50,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          // TweenAnimationBuilder(
          //   tween: Tween<double>(begin: 0, end: 1),
          //   duration: const Duration(milliseconds: 800),
          //   builder: (context, double value, child) {
          //     return Transform.scale(
          //       scale: value,
          //       child: Container(
          //         width: 100,
          //         height: 100,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           // borderRadius: BorderRadius.circular(24),
          //           boxShadow: [
          //             BoxShadow(
          //               // color: app.gradientColors[0].withOpacity(0.3),
          //               blurRadius: 20,
          //               offset: const Offset(0, 10),
          //             ),
          //           ],
          //         ),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(24),
          //           child: Image.asset(
          //             'assets/noorappsicon.png',
          //             fit: BoxFit.cover,
          //             errorBuilder: (context, error, stackTrace) {
          //               return Container(
          //                 decoration: BoxDecoration(
          //                   // gradient: LinearGradient(
          //                   //   colors: app.gradientColors,
          //                   // ),
          //                   borderRadius: BorderRadius.circular(24),
          //                 ),
          //                 child: const Icon(
          //                   Icons.apps,
          //                   size: 50,
          //                   color: Colors.white,
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // const SizedBox(height: 30),
          const Text(
            'مجموعة تطبيقات نُور',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black26,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            'تطبيقات إسلامية مجانية وخالية من الإعلانات',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.95),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAppsGrid(bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth > 600 ? 40 : 20,
          ),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: apps
                .map(
                  (app) => AppCardWidget(
                    app: app,
                    isDark: isDark,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/app-details',
                        arguments: app,
                      );
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Text(
            '© 2025 جميع الحقوق محفوظة',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'من قبل عناد أبو لاوي',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.favorite, color: Colors.red, size: 20),
              const SizedBox(width: 5),
              Text(
                'صنع بـ',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
