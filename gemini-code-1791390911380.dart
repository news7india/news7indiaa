class NewsPost {
  final int id;
  final String title;
  final String content;
  final String excerpt;
  final String link;
  final DateTime date;
  final String authorName;
  final String? featuredImageUrl;
  final String categoryName;

  NewsPost({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.link,
    required this.date,
    required this.authorName,
    this.featuredImageUrl,
    required this.categoryName,
  });

  factory NewsPost.fromJson(Map<String, dynamic> json) {
    final title = _cleanHtml(json['title']?['rendered'] ?? '');
    final content = json['content']?['rendered'] ?? '';
    final excerpt = _cleanHtml(json['excerpt']?['rendered'] ?? '');

    String author = 'News 7 India';
    if (json['_embedded']?['author'] != null &&
        (json['_embedded']['author'] as List).isNotEmpty) {
      author = json['_embedded']['author'][0]['name'] ?? 'News 7 India';
    }

    String? imageUrl;
    if (json['_embedded']?['wp:featuredmedia'] != null &&
        (json['_embedded']['wp:featuredmedia'] as List).isNotEmpty) {
      imageUrl = json['_embedded']['wp:featuredmedia'][0]['source_url'];
    }

    String category = 'सामान्य';
    if (json['_embedded']?['wp:term'] != null &&
        (json['_embedded']['wp:term'] as List).isNotEmpty) {
      final terms = json['_embedded']['wp:term'][0] as List;
      if (terms.isNotEmpty) {
        category = terms[0]['name'] ?? 'सामान्य';
      }
    }

    return NewsPost(
      id: json['id'] ?? 0,
      title: title,
      content: content,
      excerpt: excerpt,
      link: json['link'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      authorName: author,
      featuredImageUrl: imageUrl,
      categoryName: category,
    );
  }

  static String _cleanHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#8216;', "'")
        .replaceAll('&#8217;', "'")
        .replaceAll('&#8220;', '"')
        .replaceAll('&#8221;', '"')
        .trim();
  }
}