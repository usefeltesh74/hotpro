class Player {
  final int id;
  final String webName;

  Player({required this.id, required this.webName});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      webName: json['web_name'],
    );
  }
}