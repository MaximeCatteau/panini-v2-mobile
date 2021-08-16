class Player {
  final int id;
  final String username;
  final String password;

  Player({
    required this.id,
    required this.username,
    required this.password
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      username: json['username'],
      password: json['password']
    );
  }

  Map toJson() {
    return {'id': id, 'username': username };
  }
}