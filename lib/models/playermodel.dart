class Player {
  final int id;
  final String webName;
  final String photo;

  Player({required this.id, required this.webName, required this.photo});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      webName: json['web_name'],
      photo: json['photo'], // This should return a value like '462424.jpg'
    );
  }

  // Correct photo URL using PNG format
  String get photoUrl {
    // Remove the .jpg extension if it exists and replace it with .png
    final photoId = photo.replaceAll('.jpg', ''); // Remove .jpg
    return 'https://resources.premierleague.com/premierleague/photos/players/110x140/p$photoId.png';
  }
}
