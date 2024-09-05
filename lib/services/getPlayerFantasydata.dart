import 'dart:convert';
import 'package:http/http.dart' as http;

class FplPlayerdata {
  double ownership;
  double price;
  int teamPosition;

  FplPlayerdata({this.ownership = 0, this.price = 0, this.teamPosition = 0});

  final String fplBaseUrl = 'https://fantasy.premierleague.com/api/bootstrap-static/';
  final String eplStandingsUrl = 'https://api.football-data.org/v4/competitions/PL/standings';
  final String apiKey = 'a50dd087e7714b9099f882ef2eb5780e'; // Replace with your actual API key

  // Map FPL team names to Football-Data.org team names
  final Map<String, String> teamNameMapping = {
    'Arsenal': 'Arsenal FC',
    'Aston Villa': 'Aston Villa FC',
    'Bournemouth': 'AFC Bournemouth',
    'Brentford': 'Brentford FC',
    'Brighton': 'Brighton & Hove Albion FC',
    'Chelsea': 'Chelsea FC',
    'Crystal Palace': 'Crystal Palace FC',
    'Everton': 'Everton FC',
    'Fulham': 'Fulham FC',
    'Ipswich': 'Ipswich Town FC',
    'Leicester': 'Leicester City FC',
    'Liverpool': 'Liverpool FC',
    'Man City': 'Manchester City FC',
    'Man Utd': 'Manchester United FC',
    'Newcastle': 'Newcastle United FC',
    "Nott'm Forest": 'Nottingham Forest FC',
    'Southampton': 'Southampton FC',
    'Spurs': 'Tottenham Hotspur FC',
    'West Ham': 'West Ham United FC',
    'Wolves': 'Wolverhampton Wanderers FC',
  };

  Future<void> fetchPlayerData(int playerId) async {
    // Fetch player and team data from the FPL API
    final fplResponse = await http.get(Uri.parse(fplBaseUrl));
    if (fplResponse.statusCode != 200) {
      throw Exception('Failed to load FPL data');
    }
    final fplData = json.decode(fplResponse.body);

    final players = fplData['elements'];
    final teams = fplData['teams'];

    final player = players.firstWhere((p) => p['id'] == playerId, orElse: () => null);
    if (player == null) {
      throw Exception('Player not found');
    }

    final int teamId = player['team'];
    final team = teams.firstWhere((t) => t['id'] == teamId, orElse: () => null);
    if (team == null) {
      throw Exception('Team not found');
    }

    ownership = double.tryParse(player['selected_by_percent']) ?? 0.0;
    price = (player['now_cost'] / 10).toDouble();

    // Map FPL team name to Football-Data.org team name
    final fplTeamName = team['name'];
    final mappedTeamName = teamNameMapping[fplTeamName];

    if (mappedTeamName == null) {
      throw Exception('Team name not found in mapping');
    }

    // Fetch EPL standings data from Football-Data.org API
    final eplResponse = await http.get(
      Uri.parse(eplStandingsUrl),
      headers: {'X-Auth-Token': apiKey},
    );

    if (eplResponse.statusCode != 200) {
      throw Exception('Failed to load EPL standings');
    }

    final eplData = json.decode(eplResponse.body);

    // Get standings table from the Football-Data.org API
    final standings = eplData['standings'][0]['table'];

    // Find the corresponding team in the standings
    final teamInStandings = standings.firstWhere(
          (entry) => entry['team']['name'] == mappedTeamName,
      orElse: () => null,
    );

    if (teamInStandings != null) {
      teamPosition = teamInStandings['position'];
    } else {
      teamPosition = -1; // Set a default value if the team is not found
    }

    print('Team: $fplTeamName');
    print('Mapped Team: $mappedTeamName');
    print('Position: $teamPosition');
  }
}
