import 'package:flutter/material.dart';
import 'package:football_news_mobile/models/news_entry.dart';
import 'package:football_news_mobile/config/config.dart';

class NewsEntryCard extends StatelessWidget {
  final NewsEntry news;
  final VoidCallback onTap;

  const NewsEntryCard({
    super.key,
    required this.news,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                if (news.thumbnail.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      // PERBAIKAN: Gunakan Config class
                      Config.getProxyImageUrl(news.thumbnail),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $error');
                        return Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                SizedBox(height: 8),
                                Text(
                                  'Image unavailable',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (news.thumbnail.isNotEmpty) const SizedBox(height: 8),

                // Title
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Category with badge style
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    news.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // Content preview
                Text(
                  news.content.length > 100
                      ? '${news.content.substring(0, 100)}...'
                      : news.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),

                // Footer with featured badge and views
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Featured indicator
                    if (news.isFeatured)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Featured',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    
                    // Views count
                    Row(
                      children: [
                        const Icon(Icons.visibility, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${news.newsViews} views',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}