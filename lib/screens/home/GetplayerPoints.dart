import 'dart:convert';
import 'package:http/http.dart' as http;

class GetPlayerPoints {
  Future<int> fetchPlayerGameweekPoints(int gameweek, int pid) async {
    // Fetch gameweek data
    final response = await http.get(Uri.parse('https://fantasy.premierleague.com/api/event/$gameweek/live/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> players = data['elements'];

      // Find the player with the matching ID and return their points
      for (var player in players) {
        if (player['id'].toString() == '$pid') {
          return player['stats']['total_points'];
        }
      }
      throw Exception('Player not found');
    } else {
      throw Exception('Failed to load gameweek data');
    }
  }
}
