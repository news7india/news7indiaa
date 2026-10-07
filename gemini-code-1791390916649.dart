class NewsCategory {
  final int id;
  final String name;
  final int count;

  NewsCategory({
    required this.id,
    required this.name,
    required this.count,
  });

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}