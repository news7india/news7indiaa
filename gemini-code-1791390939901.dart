import 'package:flutter/material.dart';
import '../models/news_post.dart';
import 'news_detail_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final List<NewsPost> _bookmarkedPosts = [
    NewsPost(
      id: 101,
      title: 'सैंपल सेव की गई खबर',
      content: '<p>समाचार विवरण सामग्री...</p>',
      excerpt: 'संक्षिप्त विवरण...',
      link: 'https://www.news7india.com',
      date: DateTime.now().subtract(const Duration(hours: 3)),
      authorName: 'News 7 India',
      featuredImageUrl: 'https://www.news7india.com/wp-content/uploads/logo.png',
      categoryName: 'मुख्य समाचार',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('बुकमार्क (सेव की गई खबरें)'),
      ),
      body: _bookmarkedPosts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  const Text(
                    'कोई सेव की गई खबर नहीं है',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'खबरों को बाद में पढ़ने के लिए बुकमार्क करें',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _bookmarkedPosts.length,
              itemBuilder: (context, index) {
                final post = _bookmarkedPosts[index];
                return ListTile(
                  leading: post.featuredImageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            post.featuredImageUrl!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                          ),
                        )
                      : null,
                  title: Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  subtitle: Text(post.categoryName),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      setState(() {
                        _bookmarkedPosts.removeAt(index);
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsDetailScreen(post: post)),
                    );
                  },
                );
              },
            ),
    );
  }
}