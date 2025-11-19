// To parse this JSON data, do
//
//     final newsEntry = newsEntryFromJson(jsonString);

import 'dart:convert';

List<NewsEntry> newsEntryFromJson(String str) => 
    List<NewsEntry>.from(json.decode(str).map((x) => NewsEntry.fromJson(x)));

String newsEntryToJson(List<NewsEntry> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsEntry {
    String id;
    String title;
    String content;
    String category;
    String thumbnail;
    int newsViews;
    DateTime createdAt;
    bool isFeatured;
    int? userId;
    String? userUsername;

    NewsEntry({
        required this.id,
        required this.title,
        required this.content,
        required this.category,
        required this.thumbnail,
        required this.newsViews,
        required this.createdAt,
        required this.isFeatured,
        this.userId,           // PERBAIKAN: Ubah dari required menjadi optional
        this.userUsername,     // PERBAIKAN: Ubah dari required menjadi optional
    });

    factory NewsEntry.fromJson(Map<String, dynamic> json) => NewsEntry(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        content: json["content"] ?? "",
        category: json["category"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        newsViews: json["news_views"] ?? 0,
        createdAt: json["created_at"] != null 
            ? DateTime.parse(json["created_at"]) 
            : DateTime.now(),
        isFeatured: json["is_featured"] ?? false,
        userId: json["user_id"],
        userUsername: json["user_username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "category": category,
        "thumbnail": thumbnail,
        "news_views": newsViews,
        "created_at": createdAt.toIso8601String(),
        "is_featured": isFeatured,
        "user_id": userId,
        "user_username": userUsername,
    };
}