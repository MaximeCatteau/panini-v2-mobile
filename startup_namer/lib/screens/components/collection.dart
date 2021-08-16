class Collection {
  final int id;
  final String name;
  final int categoryId;

  Collection({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId'],
    );
  }
}