import 'package:flutter/material.dart';
import '../models/app_data.dart';

class AppCardWidget extends StatelessWidget {
  final AppData app;
  final bool isDark;
  final VoidCallback onTap;

  const AppCardWidget({
    Key? key,
    required this.app,
    required this.isDark,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: GestureDetector(
            onTap: onTap,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 380,
                constraints: const BoxConstraints(maxWidth: 380),
                child: Card(
                  elevation: 12,
                  shadowColor: app.gradientColors[0].withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [Colors.grey[850]!, Colors.grey[900]!]
                            : [Colors.white, Colors.grey[50]!],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildAppIcon(),
                          const SizedBox(height: 20),
                          _buildAppStats(),
                          const SizedBox(height: 15),
                          _buildAppTitle(),
                          const SizedBox(height: 12),
                          _buildAppDescription(),
                          const SizedBox(height: 20),
                          _buildViewDetailsButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppIcon() {
    return Hero(
      tag: app.id,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: app.gradientColors[0].withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            app.photo,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: app.gradientColors),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.apps, size: 50, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatBadge(
          icon: Icons.star,
          text: app.rating,
          color: app.gradientColors[0],
        ),
        const SizedBox(width: 12),
        _buildStatBadge(
          icon: Icons.download,
          text: app.downloads,
          color: app.gradientColors[1],
        ),
      ],
    );
  }

  Widget _buildStatBadge({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppTitle() {
    return Text(
      app.title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildAppDescription() {
    return Text(
      app.description,
      style: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.grey[400] : Colors.grey[700],
        height: 1.5,
      ),
      textAlign: TextAlign.center,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildViewDetailsButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: app.gradientColors),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: app.gradientColors[0].withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.arrow_back, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'عرض التفاصيل',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
