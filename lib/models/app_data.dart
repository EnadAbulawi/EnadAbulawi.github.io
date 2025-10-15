import 'package:flutter/material.dart';
import 'user_review.dart';

class AppData {
  final String id;
  final String photo;
  final String title;
  final String description;
  final List<String> features;
  final String playStoreUrl;
  final List<Color> gradientColors;
  final String rating;
  final String downloads;
  final String version;
  final List<UserReview> reviews;
  final List<String> screenshots;

  AppData({
    required this.id,
    required this.photo,
    required this.title,
    required this.description,
    required this.features,
    required this.playStoreUrl,
    required this.gradientColors,
    required this.rating,
    required this.downloads,
    required this.version,
    required this.reviews,
    this.screenshots = const [],
  });

  static List<AppData> getAllApps() {
    return [
      AppData(
        id: 'com.Noor.MushafNoor',
        photo: 'assets/noormushaf.png',
        title: 'مصحف نور',
        description:
            'تطبيق مصحف نور لقراءة القرآن الكريم، رفيقك اليومي لقراءة والاستماع لكلام الله تعالى بتجربة سلسة ومميزة',
        features: [
          '📖 نص كامل للقرآن الكريم واضح',
          '🎧 استماع بصوت +400 قارئ',
          '🔖 حفظ الآيات كإشارات مرجعية',
          '✨ مزايا مستقبلية رائعة قريباً',
          '💯 خالي تماماً من الإعلانات',
          '🎨 تصميم أنيق وسهل',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.Noor.MushafNoor',
        gradientColors: [const Color(0xFFf093fb), const Color(0xFFf5576c)],
        rating: '4.9',
        downloads: '+5,000',
        version: '1.5.2',
        reviews: [
          UserReview(
            userName: 'سارة محمود',
            comment:
                'الحمد لله تطبيق ممتاز للقراءة، الخط واضح والاستماع بجودة عالية',
            rating: 5.0,
            date: '11 يناير 2025',
          ),
          UserReview(
            userName: 'يوسف إبراهيم',
            comment: 'تطبيق مبارك، أكثر من 400 قارئ هذا شيء عظيم',
            rating: 5.0,
            date: '9 يناير 2025',
          ),
          UserReview(
            userName: 'مريم أحمد',
            comment: 'بارك الله فيكم، التطبيق بسيط وسهل الاستخدام',
            rating: 4.0,
            date: '7 يناير 2025',
          ),
        ],
      ),
      AppData(
        id: 'com.Enad.Noor',
        photo: 'assets/noor_app.png',
        title: 'نور - أدعية وأذكار',
        description:
            'رفيقك الديني الشخصي، تطبيق شامل يحتوي على كل ما يحتاجه المسلم من أدعية وأذكار يومية، آيات قرآنية، سبحة إلكترونية، منبهات للصلاة، وتذكيرات يومية',
        features: [
          '📿 سبحة إلكترونية سهلة الاستخدام',
          '🕌 منبه للصلاة مع تذكيرات يومية',
          '📖 مجموعة شاملة من الأدعية والأذكار',
          '🎙️ بودكاست وخلفيات إسلامية',
          '🌙 يعمل بدون إنترنت',
          '🎨 تصميم عصري وجذاب',
        ],
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.Enad.Noor',
        gradientColors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
        rating: '4.8',
        downloads: '+50,000',
        version: '2.1.0',
        reviews: [
          UserReview(
            userName: 'أحمد محمد',
            comment:
                'تطبيق رائع جداً! واجهة سهلة وجميلة، والسبحة الإلكترونية مفيدة جداً',
            rating: 5.0,
            date: '10 يناير 2025',
          ),
          UserReview(
            userName: 'فاطمة علي',
            comment: 'ما شاء الله تطبيق مميز، المنبهات تساعدني كثير في الصلاة',
            rating: 5.0,
            date: '8 يناير 2025',
          ),
          UserReview(
            userName: 'عبدالله خالد',
            comment: 'جزاكم الله خير، التطبيق خالي من الإعلانات وهذا شيء رائع',
            rating: 4.0,
            date: '5 يناير 2025',
          ),
        ],
      ),
    ];
  }
}
