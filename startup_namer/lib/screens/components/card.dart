class Card {
  final int id;
  final int collectionId;
  final int idInCollection;
  String imageUrl;
  final String label;
  final String cardRarity;

  Card({
    required this.id,
    required this.collectionId,
    required this.idInCollection,
    required this.imageUrl,
    required this.label,
    required this.cardRarity
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      collectionId: json['collectionId'],
      idInCollection: json['idInCollection'],
      imageUrl: json['imageUrl'],
      label: json['label'],
      cardRarity: json['cardRarity']
    );
  }

  Map toJson() {
    return {
      'id': id, 
      'collectionId': collectionId,
      'idInCollection': idInCollection,
      'imageUrl': imageUrl,
      'label': label,
      'cardRarity': cardRarity
    };
  }
}