import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/social_links.dart';

class SocialSectionWidget extends StatelessWidget {
  final bool isDark;

  const SocialSectionWidget({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.people, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'تابعنا على وسائل التواصل',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                color: const Color(0xFF1877F2),
                onTap: () => _launchURL(SocialLinks.facebook),
              ),
              _buildSocialButton(
                icon: Icons.camera_alt,
                label: 'Instagram',
                color: const Color(0xFFE4405F),
                onTap: () => _launchURL(SocialLinks.instagram),
              ),
              _buildSocialButton(
                icon: Icons.play_arrow,
                label: 'TikTok',
                color: Colors.black,
                onTap: () => _launchURL(SocialLinks.tiktok),
              ),
              _buildSocialButton(
                icon: Icons.telegram,
                label: 'Telegram',
                color: const Color(0xFF0088CC),
                onTap: () => _launchURL(SocialLinks.telegram),
              ),
              _buildSocialButton(
                icon: Icons.email,
                label: 'Email',
                color: const Color(0xFFEA4335),
                onTap: () => _launchURL('mailto:${SocialLinks.email}'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('لا يمكن فتح الرابط: $urlString');
      }
    } catch (e) {
      debugPrint('خطأ في فتح الرابط: $e');
    }
  }
}
