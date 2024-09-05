import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotpro/services/Cloud%20firestore.dart';
import 'package:provider/provider.dart';
import 'package:hotpro/screens/home/GetplayerPoints.dart';
import '../../models/fantasydata_model.dart';
import '../../models/user_model.dart';

class Resultlist extends StatefulWidget {
  const Resultlist({super.key});

  @override
  State<Resultlist> createState() => _ResultlistState();
}

class _ResultlistState extends State<Resultlist> {
  Fantasy_model? fantUser;
  int p1oints=0,p2oints=0,p3oints=0;
  GetPlayerPoints getpoints = GetPlayerPoints();
  Future<void> updatePoints() async {
    try {
      final p1 = await getpoints.fetchPlayerGameweekPoints(3, fantUser!.player1id);
      final p2 = await getpoints.fetchPlayerGameweekPoints(3, fantUser!.player2id);
      final p3 = await getpoints.fetchPlayerGameweekPoints(3, fantUser!.player3id);

      setState(() {
        p1oints = p1;
        p2oints = p2;
        p3oints = p3;

      });
    } catch (e) {
      print('Error fetching player points: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching player points. Please try again.')),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updatePoints();
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
          Gwbiid: doc['teambid'],
          profit: doc['profit'],
          Budget: doc['Budget'],
          play: doc['play'],
        );
        break; // Stop looping after finding the matching document
      }
    }

    if (fantUser == null) {
      return const Center(child: Text('No data available'));
    }

    return RefreshIndicator(
      onRefresh: updatePoints,
        // setState(() {
        //   DatabaseService(uid: userinfo!.userid).updateUserData(fantUser!.username, fantUser!.player1, fantUser!.player1bid, fantUser!.player1id,p1oints, fantUser!.player2, fantUser!.player2bid, fantUser!.player2id, p2oints, fantUser!.player3, fantUser!.player3bid, fantUser!.player3id, p3oints, fantUser!.Gwbiid, fantUser!.profit, fantUser!.Budget, fantUser!.play);
        // });


      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.tealAccent,
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

          Text(
            "Your GW bets ${fantUser?.username} :",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
          Card(
            color: Colors.teal[50],
            child: ListTile(
              title: const Text('Player 1',),
              subtitle: Text(fantUser!.player1,style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold)),
              trailing: Text("$p1oints Pts",style: TextStyle(color: Colors.green,fontSize: 24),),
            ),
          ),
          Card(
            color: Colors.teal[50],
            child: ListTile(
              title: const Text('Player 1 Bet'),
              subtitle: Text(fantUser!.player1bid.toString(),style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ),
          Card(
            color: Colors.teal[50],
            child: ListTile(
              title: const Text('Player 2'),
              subtitle: Text(fantUser!.player2,style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold)),
              trailing: Text("$p2oints Pts",style: TextStyle(color: Colors.green,fontSize: 24),),
            ),
          ),

          Card(
            color: Colors.teal[50],
            child: ListTile(
              title: const Text('Player 2 Bet'),
              subtitle: Text(fantUser!.player2bid.toString(),style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold)),
            ),
          ),
          Card(
            color: Colors.teal[50],
            child: ListTile(
              title: const Text('Player 3'),
              subtitle: Text(fantUser!.player3,style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold)),
              trailing: Text("$p3oints Pts",style: TextStyle(color: Colors.green,fontSize: 24),),
            ),
          ),
          Card(
            color: Colors.teal[50],
            child: ListTile(
              title: const Text('Player 3 Bet'),
              subtitle: Text(fantUser!.player3bid.toString(),style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold)),
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
