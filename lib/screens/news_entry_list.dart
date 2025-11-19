import 'package:flutter/material.dart';
import 'package:football_news_mobile/models/news_entry.dart';
import 'package:football_news_mobile/widgets/left_drawer.dart';
import 'package:football_news_mobile/screens/news_detail.dart';
import 'package:football_news_mobile/widgets/news_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_news_mobile/config/config.dart';

class NewsEntryListPage extends StatefulWidget {
  const NewsEntryListPage({super.key});

  @override
  State<NewsEntryListPage> createState() => _NewsEntryListPageState();
}

class _NewsEntryListPageState extends State<NewsEntryListPage> {
  Future<List<NewsEntry>> fetchNews(CookieRequest request) async {
    try {
      // Gunakan Config class
      final response = await request.get(Config.newsListUrl);
      
      // Debug: print response untuk melihat struktur data
      print('Response from API: $response');
      
      // Decode response
      var data = response;
      
      // Convert json data to NewsEntry objects
      List<NewsEntry> listNews = [];
      for (var d in data) {
        if (d != null) {
          try {
            listNews.add(NewsEntry.fromJson(d));
          } catch (e) {
            print('Error parsing news item: $e');
            print('Problematic data: $d');
          }
        }
      }
      return listNews;
    } catch (e) {
      print('Error fetching news: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Entry List'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchNews(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {}); // Refresh
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.newspaper,
                    size: 60,
                    color: Color(0xff59A5D8),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'There are no news in football news yet.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => NewsEntryCard(
                news: snapshot.data![index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(
                        news: snapshot.data![index],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}