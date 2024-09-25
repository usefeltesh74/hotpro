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
              profit: doc['profit'],
              Budget: doc['Budget'],
              play: doc['play'],
              GWprofit: doc['GWprofit'],
              stand_GW: doc['stand_GW'],
              player1profit : doc['player1profit'],
              player2profit: doc['player2profit'],
              player3profit :doc['player3profit'],
              stand_player1: doc['stand_player1'],
              stand_player1bet: doc['stand_player1bet'],
              stand_player2: doc['stand_player2'],
              stand_player2bet: doc['stand_player2bet'],
              stand_player3: doc['stand_player3'],
              stand_player3bet: doc['stand_player3bet'],
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
                        if(game.stand_player1 == '')
                          {game.stand_player1 = 'NotSelected';}
                        if(game.stand_player2 == '')
                        {game.stand_player2 = 'NotSelected';}
                        if(game.stand_player3 == '')
                        {game.stand_player3 = 'NotSelected';}
                        return Card(
                          color: Colors.grey[200],
                          child: ExpansionTile(
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
                                Text('GW${game.stand_GW} Profit: ${game.GWprofit}',style: TextStyle(color: Colors.teal[700]),),
                                Text(
                                  'Total Profit: ${game.profit}',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.expand_more, // Expand icon
                              size: 30,
                              color: Colors.orange[600], // Customize the color of the icon
                            ),
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange[400],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 7,
                                      blurRadius: 13,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(20), // Adds padding to the container
                                child: Column(
                                  children: <Widget>[
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("${listgamedata[index].stand_player1},",style: TextStyle(fontSize: 14),),
                                          SizedBox(width: 10), // Add space between elements
                                          Text(
                                            'bet: ${listgamedata[index].stand_player1bet},',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("profit: ${listgamedata[index].player1profit}",style: TextStyle(fontSize: 14),)
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10), // Space between rows
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("${listgamedata[index].stand_player2},"),
                                          SizedBox(width: 10),
                                          Text(
                                            'bet: ${listgamedata[index].stand_player2bet},',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("profit: ${listgamedata[index].player2profit}")
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("${listgamedata[index].stand_player3},"),
                                          SizedBox(width: 10),
                                          Text(
                                            'bet: ${listgamedata[index].stand_player3bet},',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("profit: ${listgamedata[index].player3profit}")
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
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
