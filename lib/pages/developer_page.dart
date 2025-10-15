import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF1a1a2e), const Color(0xFF16213e)]
                : [const Color(0xFF667eea), const Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context, isDark),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildProfileSection(isDark),
                      const SizedBox(height: 30),
                      _buildAboutSection(isDark),
                      const SizedBox(height: 30),
                      _buildSkillsSection(isDark),
                      const SizedBox(height: 30),
                      _buildJourneySection(isDark),
                      const SizedBox(height: 30),
                      _buildAchievementsSection(isDark),
                      const SizedBox(height: 30),
                      _buildContactSection(isDark),
                      const SizedBox(height: 40),
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

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'المطور',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget _buildProfileSection(bool isDark) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667eea).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'ع',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'عناد أبو لاوي',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'مطور تطبيقات موبايل | Flutter Developer',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                _buildBadge('📱 Flutter', const Color(0xFF02569B)),
                _buildBadge('🎨 UI/UX', const Color(0xFFE91E63)),
                _buildBadge('☁️ Firebase', const Color(0xFFFFCA28)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildAboutSection(bool isDark) {
    return _buildSection(
      isDark: isDark,
      title: 'نبذة عني',
      icon: Icons.person,
      child: Text(
        'مطور تطبيقات موبايل متخصص في Flutter، شغوف بتطوير تطبيقات إسلامية مجانية تخدم المسلمين حول العالم. أؤمن بأن التكنولوجيا يجب أن تكون في خدمة الإنسانية وتسهيل حياة الناس.',
        style: TextStyle(
          fontSize: 16,
          height: 1.8,
          color: isDark ? Colors.grey[300] : Colors.grey[700],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSkillsSection(bool isDark) {
    final skills = [
      {'name': 'Flutter', 'level': 0.9, 'color': const Color(0xFF02569B)},
      {'name': 'Dart', 'level': 0.85, 'color': const Color(0xFF0175C2)},
      {'name': 'Firebase', 'level': 0.8, 'color': const Color(0xFFFFCA28)},
      {'name': 'UI/UX Design', 'level': 0.75, 'color': const Color(0xFFE91E63)},
      {'name': 'Git & GitHub', 'level': 0.8, 'color': const Color(0xFF181717)},
    ];

    return _buildSection(
      isDark: isDark,
      title: 'المهارات البرمجية',
      icon: Icons.code,
      child: Column(
        children: skills.map((skill) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      skill['name'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      '${((skill['level'] as double) * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 14,
                        color: skill['color'] as Color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: skill['level'] as double,
                    backgroundColor: isDark
                        ? Colors.grey[800]
                        : Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(skill['color'] as Color),
                    minHeight: 10,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildJourneySection(bool isDark) {
    final journey = [
      {
        'year': '2023',
        'title': 'إطلاق تطبيق نور',
        'description': 'أول تطبيق إسلامي شامل للأدعية والأذكار',
      },
      {
        'year': '2024',
        'title': 'إطلاق مصحف نور',
        'description': 'تطبيق قراءة واستماع القرآن الكريم',
      },
      {
        'year': '2025',
        'title': 'تطوير موقع العرض',
        'description': 'إنشاء منصة عرض احترافية للتطبيقات',
      },
    ];

    return _buildSection(
      isDark: isDark,
      title: 'رحلتي في التطوير',
      icon: Icons.timeline,
      child: Column(
        children: journey.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      item['year']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['description']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAchievementsSection(bool isDark) {
    return _buildSection(
      isDark: isDark,
      title: 'الإنجازات',
      icon: Icons.emoji_events,
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: [
          _buildAchievementCard(
            isDark: isDark,
            icon: Icons.download,
            title: '+15,000',
            subtitle: 'تحميل',
            color: const Color(0xFF4CAF50),
          ),
          _buildAchievementCard(
            isDark: isDark,
            icon: Icons.star,
            title: '4.8+',
            subtitle: 'متوسط التقييم',
            color: const Color(0xFFFFB300),
          ),
          _buildAchievementCard(
            isDark: isDark,
            icon: Icons.apps,
            title: '2',
            subtitle: 'تطبيق منشور',
            color: const Color(0xFF2196F3),
          ),
          _buildAchievementCard(
            isDark: isDark,
            icon: Icons.people,
            title: '1000+',
            subtitle: 'مستخدم نشط',
            color: const Color(0xFFE91E63),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard({
    required bool isDark,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(bool isDark) {
    return _buildSection(
      isDark: isDark,
      title: 'تواصل معي',
      icon: Icons.contact_mail,
      child: Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: [
          _buildContactButton(
            icon: Icons.email,
            label: 'البريد الإلكتروني',
            color: const Color(0xFFEA4335),
            onTap: () => _launchURL('mailto:your-email@example.com'),
          ),
          _buildContactButton(
            icon: Icons.code,
            label: 'GitHub',
            color: const Color(0xFF181717),
            onTap: () => _launchURL('https://github.com/enadabulawi'),
          ),
          _buildContactButton(
            icon: Icons.work,
            label: 'LinkedIn',
            color: const Color(0xFF0A66C2),
            onTap: () => _launchURL('https://linkedin.com/in/your-profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
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
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required bool isDark,
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: const Color(0xFF667eea), size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('خطأ: $e');
    }
  }
}
