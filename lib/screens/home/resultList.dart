import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotpro/services/Cloud%20firestore.dart';
import 'package:provider/provider.dart';
import 'package:hotpro/screens/home/GetplayerPoints.dart';
import '../../models/fantasydata_model.dart';
import '../../models/user_model.dart';
import '../../shared/constants.dart';

class Resultlist extends StatefulWidget {
  const Resultlist({super.key});

  @override
  State<Resultlist> createState() => _ResultlistState();
}

class _ResultlistState extends State<Resultlist> {
  Fantasy_model? fantUser;
  int p1oints=0,p2oints=0,p3oints=0;
  GetPlayerPoints getpoints = GetPlayerPoints();
  Future<void> updatePoints(int GW) async {
    try {
      final p1 = await getpoints.fetchPlayerGameweekPoints(GW, fantUser!.player1id);
      final p2 = await getpoints.fetchPlayerGameweekPoints(GW, fantUser!.player2id);
      final p3 = await getpoints.fetchPlayerGameweekPoints(GW, fantUser!.player3id);

      setState(() {
        p1oints = p1;
        p2oints = p2;
        p3oints = p3;

      });
    } catch (e) {
      print('Error fetching player points: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("The game week hasn't started yet. ")),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (fantUser != null) {
        updatePoints(fantUser!.GW); // Use the gameweek from fantUser
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final userinfo = Provider.of<Userinfo?>(context);
    final gamedata = Provider.of<QuerySnapshot<Object?>?>(context);
    if (gamedata == null) {
      return const Center(child: CircularProgressIndicator());
    }

    for (var doc in gamedata.docs) {
      if (userinfo?.userid == doc.id) {
        fantUser = Fantasy_model(
          username: doc['username'],
          player1: doc['player1'],
          player2: doc['player2'],
          player3: doc['player3'],
          player1bid: doc['player1bid'],
          player2bid: doc['player2bid'],
          player3bid: doc['player3bid'],
          player1points: doc['player1points'],
          player2points: doc['player2points'],
          player3points: doc['player3points'],
          player1id: doc['player1id'],
          player2id: doc['player2id'],
          player3id: doc['player3id'],
          p1ows: doc['player1ows'],
          p2ows: doc['player2ows'],
          p3ows: doc['player3ows'],
          p1price: doc['player1price'],
          p2price: doc['player2price'],
          p3price: doc['player3price'],
          t1pos: doc['player1 team position'],
          t2pos: doc['player2 team position'],
          t3pos: doc['player3 team position'],
          Gwbiid: doc['teambid'],
          profit: doc['profit'],
          Budget: doc['Budget'],
          play: doc['play'],
          GW:doc['GW'],
        );
        break; // Stop looping after finding the matching document
      }
    }

    if (fantUser == null) {
      return const Center(child: Text('No data available'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (fantUser != null) {
          await updatePoints(fantUser!.GW); // Use the gameweek from fantUser
        }
      },
        // setState(() {
        //   DatabaseService(uid: userinfo!.userid).updateUserData(fantUser!.username, fantUser!.player1, fantUser!.player1bid, fantUser!.player1id,p1oints, fantUser!.player2, fantUser!.player2bid, fantUser!.player2id, p2oints, fantUser!.player3, fantUser!.player3bid, fantUser!.player3id, p3oints, fantUser!.Gwbiid, fantUser!.profit, fantUser!.Budget, fantUser!.play);
        // });


      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.orange[400],
            elevation: 3,
            margin: EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Budget:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${fantUser?.Budget.toString() ?? '0'}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Your GW${fantUser!.GW} bets ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              TextSpan(
                text: "${fantUser?.username} 👋",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange, shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  ),
                ]),
              ),
            ],
          ),
        ),

        // Replace the ListTile for Player 1 with an ExpansionTile
          Container(
            margin: EdgeInsets.symmetric(vertical: 10), // Adds vertical space between tiles
            decoration: BoxDecoration(
              color: Colors.teal[50],
              shape: BoxShape.rectangle, // Ensures the shape is a rounded rectangle
              borderRadius: BorderRadius.circular(20), // Circular edges
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent, // Remove the divider line
              ),
              child: ExpansionTile(
                title: Text(
                  'Player 1',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  fantUser!.player1,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "$p1oints Pts",
                      style: TextStyle(color: Colors.green, fontSize: 24),
                    ),
                    SizedBox(width: 60,),
                    Icon(
                    Icons.expand_more, // Expand icon
                    size: 30,
                    color: Colors.orange[600], // Customize the color of the icon
                  ),
                ]
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("bet :"),
                            Text(
                              '\$${fantUser!.player1bid}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Space between rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("ownership :"),
                            Text(
                              '${fantUser!.p1ows}%',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Cost :"),
                            Text(
                              '\$${fantUser!.p1price}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Team Position :"),
                            Text(
                              '${fantUser!.t1pos}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10), // Adds vertical space between tiles
            decoration: BoxDecoration(
              color: Colors.teal[50],
              shape: BoxShape.rectangle, // Ensures the shape is a rounded rectangle
              borderRadius: BorderRadius.circular(20), // Circular edges
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent, // Remove the divider line
              ),
              child: ExpansionTile(
                title: Text(
                  'Player 2',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  fantUser!.player2,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "$p2oints Pts",
                        style: TextStyle(color: Colors.green, fontSize: 24),
                      ),
                      SizedBox(width: 60,),
                      Icon(
                        Icons.expand_more, // Expand icon
                        size: 30,
                        color: Colors.orange[600], // Customize the color of the icon
                      ),
                    ]
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("bet :"),
                            Text(
                              '\$${fantUser!.player2bid}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Space between rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("ownership :"),
                            Text(
                              '${fantUser!.p2ows}%',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Cost :"),
                            Text(
                              '\$${fantUser!.p2price}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Team Position :"),
                            Text(
                              '${fantUser!.t2pos}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10), // Adds vertical space between tiles
            decoration: BoxDecoration(
              color: Colors.teal[50],
              shape: BoxShape.rectangle, // Ensures the shape is a rounded rectangle
              borderRadius: BorderRadius.circular(20), // Circular edges
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent, // Remove the divider line
              ),
              child: ExpansionTile(
                title: Text(
                  'Player 3',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  fantUser!.player3,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "$p3oints Pts",
                        style: TextStyle(color: Colors.green, fontSize: 24),
                      ),
                      SizedBox(width: 60,),
                      Icon(
                        Icons.expand_more, // Expand icon
                        size: 30,
                        color: Colors.orange[600], // Customize the color of the icon
                      ),
                    ]
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("bet :"),
                            Text(
                              '\$${fantUser!.player3bid}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), // Space between rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("ownership :"),
                            Text(
                              '${fantUser!.p3ows}%',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Cost :"),
                            Text(
                              '\$${fantUser!.p3price}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Team Position :"),
                            Text(
                              '${fantUser!.t3pos}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),


                Card(
                  color: Colors.teal[50],
                  child: ListTile(
                    title: const Text('Team Bet'),
                    subtitle: Text(fantUser!.Gwbiid.toString(),style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                ),

        ],
      ),
    );
  }
}
