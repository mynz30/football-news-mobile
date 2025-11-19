// lib/config/config.dart
class Config {
  // PENTING: Ganti dengan URL production Anda
  // Untuk Android Emulator: http://10.0.2.2:8000
  // Untuk Web/Chrome: http://localhost:8000
  // Untuk Production: https://faishal-khoiriansyah-footballnews.pbp.cs.ui.ac.id
  
  static const String baseUrl = 'http://localhost:8000';

  // AUTHENTICATION ENDPOINTS
  static const String loginUrl = '$baseUrl/auth/login/';
  static const String registerUrl = '$baseUrl/auth/register/';
  static const String logoutUrl = '$baseUrl/auth/logout/';

  // NEWS ENDPOINTS
  static const String newsListUrl = '$baseUrl/json/';
  static const String createNewsUrl = '$baseUrl/create-flutter/';
  static const String proxyImageUrl = '$baseUrl/proxy-image/';

  // Helper method untuk build proxy image URL
  static String getProxyImageUrl(String imageUrl) {
    return '$proxyImageUrl?url=${Uri.encodeComponent(imageUrl)}';
  }
}