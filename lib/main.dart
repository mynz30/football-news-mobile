import 'package:flutter/material.dart';
import 'package:football_news_mobile/menu.dart'; // Pastikan path ini benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Perubahan skema warna sesuai Langkah 1
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
        .copyWith(secondary: Colors.blueAccent[400]),
        useMaterial3: true, // Tambahan opsional untuk menggunakan Material 3
      ),
      // Sesuai Langkah 2: Memanggil konstruktor tanpa argumen title
      home: MyHomePage(),
    );
  }
}