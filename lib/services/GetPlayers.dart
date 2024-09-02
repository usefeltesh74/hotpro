import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotpro/models/playermodel.dart';
class GetPlayers{
  List<Player>? allPlayers ;
  List<Player>? filteredPlayers;

  GetPlayers({ this.allPlayers, this.filteredPlayers});

  Future<void> fetchPlayers() async {
    final response = await http.get(
      Uri.parse("https://fantasy.premierleague.com/api/bootstrap-static/"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

        allPlayers = (data['elements'] as List)
            .map((player) => Player.fromJson(player))
            .toList();
        filteredPlayers = allPlayers; // Initialize filtered players

    } else {
      throw Exception("Failed to load players");
    }
  }

  //for search on player
  void filterPlayers(String query) {
    final suggestions = allPlayers?.where((player) {
      final playerName = player.webName.toLowerCase();
      final input = query.toLowerCase();
      return playerName.contains(input);
    }).toList();


      filteredPlayers = suggestions;

  }
}