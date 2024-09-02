import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/playermodel.dart';
import 'services/GetPlayers.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlayerSearchPage(),
    );
  }
}

class PlayerSearchPage extends StatefulWidget {
  @override
  _PlayerSearchPageState createState() => _PlayerSearchPageState();
}

class _PlayerSearchPageState extends State<PlayerSearchPage> {
  List<Player> allPlayers = [];
  List<Player> filteredPlayers = [];
  String selectedPlayer = '';
  GetPlayers gPlayers = GetPlayers();

  @override
  void initState() {
    super.initState();
    gPlayers.fetchPlayers();
  }

  // Fetch players from the FPL API


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search EPL Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val){setState(() {
                gPlayers.filterPlayers(val);
                filteredPlayers = gPlayers.filteredPlayers!;
              });

              },
              decoration: InputDecoration(
                labelText: 'Search Player',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlayers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredPlayers[index].webName),
                    onTap: () {
                      setState(() {
                        selectedPlayer = filteredPlayers[index].webName;
                      });
                    },
                  );
                },
              ),
            ),
            if (selectedPlayer != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Selected Player: $selectedPlayer'),
              ),
          ],
        ),
      ),
    );
  }
}

// Player model to store player data

