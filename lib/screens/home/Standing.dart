import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotpro/models/fantasydata_model.dart';
import 'package:hotpro/shared/constants.dart';

class StandingsPage extends StatelessWidget {
  final CollectionReference gamedata;

  StandingsPage({required this.gamedata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[600],
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text(
          'Standing Table',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange, shadows: [
            Shadow(
              blurRadius: 10.0,
              color: Colors.black,
              offset: Offset(2.0, 2.0),
            ),
          ]),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: gamedata.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          List<Fantasy_model> listgamedata = snapshot.data!.docs.map((doc) {
            return Fantasy_model(
              username: doc['username'],
              player1: doc['player1'],
              player2: doc['player2'],
              player3: doc['player3'],
              player1bid: doc['player1bid'],
              player2bid: doc['player2bid'],
              player3bid: doc['player3bid'],
              Gwbiid: doc['teambid'],
              profit: doc['profit'],
              Budget: doc['Budget'],
              play: doc['play'],
              GWprofit: doc['GWprofit'],
              GW : doc['GW'],
            );
          }).toList();

          // Sort the list by profit in descending order
          listgamedata.sort((a, b) => b.profit.compareTo(a.profit));

          return Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 7,
                  blurRadius: 13,
                  offset: Offset(0, 3),
                )
              ],
            ),
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: listgamedata.length,
                      itemBuilder: (context, index) {
                        Fantasy_model game = listgamedata[index];
                        return Card(
                          color: Colors.grey[200],
                          child: ListTile(
                            leading: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            title: Text(
                              game.username,
                              style: TextStyle(
                                color: Colors.deepOrange[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('GW${game.GW} Profit: ${game.GWprofit}',style: TextStyle(color: Colors.teal[700]),),
                                Text(
                                  'Total Profit: ${game.profit}',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                                ),
                              ],
                            )
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
