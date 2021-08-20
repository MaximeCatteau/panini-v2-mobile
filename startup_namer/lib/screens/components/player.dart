class Player {
  final int id;
  final String username;
  final String password;
  int cashCard;

  Player({
    required this.id,
    required this.username,
    required this.password,
    required this.cashCard
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      cashCard: json['cashCard']
    );
  }

  Map toJson() {
    return {'id': id, 'username': username };
  }
}