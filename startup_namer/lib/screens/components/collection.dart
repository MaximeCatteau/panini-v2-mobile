class Collection {
  final int id;
  final String name;
  final int categoryId;
  final String imageUrl;
  final int price;

  Collection({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.imageUrl,
    required this.price
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId'],
      imageUrl: json['imageUrl'],
      price: json['price']
    );
  }
}