// lib/config/config.dart
// File konfigurasi untuk centralize semua URL endpoints

class Config {
  // BASE URL - UBAH SESUAI KEBUTUHAN
  // Untuk Android Emulator: http://10.0.2.2:8000
  // Untuk Web/Chrome: http://localhost:8000
  static const String baseUrl = 'http://10.0.2.2:8000';

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