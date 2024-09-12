import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotpro/screens/home/Gamelist.dart';
import 'package:hotpro/screens/home/Play_or_Not.dart';
import 'package:hotpro/screens/home/resultList.dart';
import 'package:hotpro/services/auth.dart';
import 'package:hotpro/trysearchplayers.dart';
import 'package:provider/provider.dart';
import 'package:hotpro/models/user_model.dart';
import 'package:hotpro/services/Cloud firestore.dart';
import '../../models/fantasydata_model.dart';
import 'package:hotpro/screens/home/Standing.dart';

class home extends StatelessWidget {
  final fireauth _authserv = fireauth(); // Instantiate in the constructor or use a provider
  @override
  Widget build(BuildContext context) {
    final userinfo = Provider.of<Userinfo?>(context);

    final List<Map<String, dynamic>> ownershipMultiplierDivider = [
      {'ownership': 0, 'multiplier': 0.6, 'divider': 0.1},
      {'ownership': 2, 'multiplier': 0.58, 'divider': 0.12},
      {'ownership': 4, 'multiplier': 0.55, 'divider': 0.15},
      {'ownership': 6, 'multiplier': 0.52, 'divider': 0.18},
      {'ownership': 8, 'multiplier': 0.49, 'divider': 0.21},
      {'ownership': 10, 'multiplier': 0.46, 'divider': 0.24},
      {'ownership': 12, 'multiplier': 0.43, 'divider': 0.27},
      {'ownership': 14, 'multiplier': 0.4, 'divider': 0.3},
      {'ownership': 16, 'multiplier': 0.37, 'divider': 0.33},
      {'ownership': 18, 'multiplier': 0.34, 'divider': 0.36},
      {'ownership': 20, 'multiplier': 0.3, 'divider': 0.4},
      {'ownership': 22, 'multiplier': 0.27, 'divider': 0.43},
      {'ownership': 24, 'multiplier': 0.24, 'divider': 0.46},
      {'ownership': 26, 'multiplier': 0.21, 'divider': 0.49},
      {'ownership': 28, 'multiplier': 0.18, 'divider': 0.52},
      {'ownership': 30, 'multiplier': 0.15, 'divider': 0.55},
      {'ownership': 32, 'multiplier': 0.12, 'divider': 0.58},
      {'ownership': 34, 'multiplier': 0.1, 'divider': 0.61},
      {'ownership': 36, 'multiplier': 0.1, 'divider': 0.64},
      {'ownership': 38, 'multiplier': 0.1, 'divider': 0.67},
      {'ownership': 40, 'multiplier': 0.1, 'divider': 0.7},
      // Add the rest here...
    ];

    final List<Map<String, dynamic>> teamRankingMultiplierDivider = [
      {'teamRanking': 1, 'multiplier': 0.1, 'divider': 0.6},
      {'teamRanking': 2, 'multiplier': 0.13, 'divider': 0.57},
      {'teamRanking': 3, 'multiplier': 0.16, 'divider': 0.54},
      {'teamRanking': 4, 'multiplier': 0.19, 'divider': 0.51},
      {'teamRanking': 5, 'multiplier': 0.22, 'divider': 0.48},
      {'teamRanking': 6, 'multiplier': 0.25, 'divider': 0.45},
      {'teamRanking': 7, 'multiplier': 0.28, 'divider': 0.42},
      {'teamRanking': 8, 'multiplier': 0.31, 'divider': 0.39},
      {'teamRanking': 9, 'multiplier': 0.34, 'divider': 0.36},
      {'teamRanking': 10, 'multiplier': 0.37, 'divider': 0.33},
      {'teamRanking': 11, 'multiplier': 0.4, 'divider': 0.3},
      {'teamRanking': 12, 'multiplier': 0.43, 'divider': 0.27},
      {'teamRanking': 13, 'multiplier': 0.46, 'divider': 0.24},
      {'teamRanking': 14, 'multiplier': 0.49, 'divider': 0.21},
      {'teamRanking': 15, 'multiplier': 0.52, 'divider': 0.18},
      {'teamRanking': 16, 'multiplier': 0.55, 'divider': 0.15},
      {'teamRanking': 17, 'multiplier': 0.58, 'divider': 0.12},
      {'teamRanking': 18, 'multiplier': 0.61, 'divider': 0.1},
      {'teamRanking': 19, 'multiplier': 0.64, 'divider': 0.1},
      {'teamRanking': 20, 'multiplier': 0.67, 'divider': 0.1},
    ];

    final List<Map<String, dynamic>> priceMultiplierDivider = [
      {'price': 4.5, 'multiplier': 0.6, 'divider': 0.2},
      {'price': 5, 'multiplier': 0.55, 'divider': 0.25},
      {'price': 5.5, 'multiplier': 0.5, 'divider': 0.3},
      {'price': 6, 'multiplier': 0.45, 'divider': 0.35},
      {'price': 6.5, 'multiplier': 0.4, 'divider': 0.4},
      {'price': 7, 'multiplier': 0.35, 'divider': 0.45},
      {'price': 7.5, 'multiplier': 0.3, 'divider': 0.5},
      {'price': 8, 'multiplier': 0.25, 'divider': 0.55},
      {'price': 8.5, 'multiplier': 0.25, 'divider': 0.57},
      {'price': 9.5, 'multiplier': 0.2, 'divider': 0.6},
      {'price': 10, 'multiplier': 0.2, 'divider': 0.6},
      {'price': 10.5, 'multiplier': 0.2, 'divider': 0.6},
      {'price': 12.5, 'multiplier': 0.15, 'divider': 0.7},
      {'price': 15, 'multiplier': 0.1, 'divider': 0.75},
    ];

    final List<Map<String, dynamic>> TeamMultiplierDivider = [
      {'points': 10, 'multiplier': 1.1, 'divider': 1.1},
      {'points': 20, 'multiplier': 1.2, 'divider': 1.2},
      {'points': 30, 'multiplier': 1.3, 'divider': 1.3},
      {'points': 40, 'multiplier': 1.4, 'divider': 1.4},
      {'points': 50, 'multiplier': 1.5, 'divider': 1.5},
      {'points': 60, 'multiplier': 1.6, 'divider': 1.6},
      {'points': 70, 'multiplier': 1.7, 'divider': 1.7},
      {'points': 80, 'multiplier': 1.8, 'divider': 1.8},
      {'points': 90, 'multiplier': 1.9, 'divider': 1.9},
      {'points': 100, 'multiplier': 2.0, 'divider': 2.0},
    ];

    void _showownership(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  'Ownership Multipliers and Dividers',
                  style: TextStyle(fontSize: 18,color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                ...ownershipMultiplierDivider.map((factor) => Text(
                  "Ownership: ${factor['ownership']}, Multiplier: ${factor['multiplier']}, Divider: ${factor['divider']}",
                )),
              ],
            ),
          );
        },
      );
    }

    void _showoprice(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  'Price Multipliers and Dividers',
                  style: TextStyle(fontSize: 18,color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                ...priceMultiplierDivider.map((factor) => Text(
                  "Price: ${factor['price']}, Multiplier: ${factor['multiplier']}, Divider: ${factor['divider']}",
                )),
                SizedBox(height: 20,)
              ],
            ),
          );
        },
      );
    }

    void _showoteamranking(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  'Team Ranking Multipliers and Dividers',
                  style: TextStyle(fontSize: 18, color: Colors.orange,fontWeight: FontWeight.bold),
                ),
                ...teamRankingMultiplierDivider.map((factor) => Text(
                  "Team Ranking: ${factor['teamRanking']}, Multiplier: ${factor['multiplier']}, Divider: ${factor['divider']}",
                )),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    }

    void _showteambet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  'TeamBet Multipliers and Dividers',
                  style: TextStyle(fontSize: 18,color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                ...TeamMultiplierDivider.map((factor) => Text(
                  "Points: ${factor['points']}, Multiplier: ${factor['multiplier']}, Divider: ${factor['divider']}",
                )),
              ],
            ),
          );
        },
      );
    }

    void _showDescription(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Game Description',
                    style: TextStyle(fontSize: 24,color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => _showownership(context),
                        child: Text("OWS",style: TextStyle(color: Colors.orange,fontSize: 14,fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                      ),
                      ElevatedButton(
                        onPressed: () => _showoprice(context),
                        child: Text("Cost",style: TextStyle(color: Colors.orange,fontSize: 14,fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                      ),
                      ElevatedButton(
                        onPressed: () => _showoteamranking(context),
                        child: Text("Rank",style: TextStyle(color: Colors.orange,fontSize: 14,fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                      ),
                      ElevatedButton(
                        onPressed: () => _showteambet(context),
                        child: Text("team",style: TextStyle(color: Colors.orange,fontSize: 14,fontWeight: FontWeight.bold),),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    "Start with a budget of 1 million and each gameweek, you bet on 3 players to score more than a certain number of points. "
                        "For every point you think they’ll score, you bet 10k from your budget. For example, if you bet a player will get 7 points, "
                        "you’ll bet 70k. If the player hits the target, you get your 70k back plus extra profit. The profit depends on how many people "
                        "own the player, their price, and how well their team is doing in the league."
                        "\n\nBig players like Haaland will give you less profit but have bigger losses if they don’t meet the points. If they miss the target, "
                        "a lot of your 70k will be taken from your overall profit, and you’ll get the rest back in your budget. Smaller players like Amad Diallo "
                        "give you bigger profit and smaller losses. If they hit their points, you win more money, but if they don’t, you lose less."
                        "\n\nThe leaderboard is based on who has the most profit. The higher your profit, the higher your rank. You can also bet on how many points "
                        "your Fantasy Premier League team will score each gameweek. Every 10 points you think they’ll score equals a 10k bet, just like with the players."
                        "\n\nPlay smart, make profits, and become the best in FantasyXbet!",
                    // Shortened for brevity; add your game description here
                  ),

                ],
              ),
            ),
          );
        },
      );
    }

    // Function to show factors in a second bottom sheet



    if (userinfo == null) {
      // Handle the case where userinfo is null
      return Scaffold(
        body: Center(child: Text('User not authenticated')),
      );
    }
    else
      {
        print("signed in :${userinfo.userid}");
      }

    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DatabaseService(uid: userinfo.userid).fandata,
      child: Scaffold(
        backgroundColor: Colors.teal[400],
          appBar: AppBar(
            //leading: Image.asset("assets/12-121809_premier-league-white-logo-hd-png-download.png"),
            title: Text("FantasyXbet", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.orange, shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ]),),
            //centerTitle: true,
            backgroundColor: Colors.teal[600],
            actions: <Widget>[

              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.logout,color: Colors.orange,),
                  label: Text("Log out",style: TextStyle(color: Colors.orange),),
                  onPressed: () async {
                    try {
                      await _authserv.Sign_out();
                    } catch (e) {
                      print('Sign-out error: $e');
                    }
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.leaderboard),
                onPressed: () {
                  final gamedata = DatabaseService(uid: userinfo.userid).emer();

                  if (gamedata != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StandingsPage(gamedata: gamedata)),
                    );
                  } else {
                    // Handle the case where gamedata is null, e.g., show a message or do nothing
                    print('Game data is not available');
                  }
                },
              ),
              IconButton(onPressed: () => _showDescription(context), icon: Icon(Icons.info)),
            ],
          ),

          body: PlayOrNot(),
      ),
    );
  }
}
