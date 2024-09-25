import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hotpro/services/Cloud%20firestore.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotpro/models/user_model.dart';
import 'package:hotpro/models/fantasydata_model.dart';
import 'package:hotpro/shared/constants.dart';
import 'package:hotpro/screens/home/dropdownmenu.dart';
import 'package:hotpro/screens/home/teamDropmenu.dart';
import 'package:hotpro/models/playermodel.dart';
import 'package:hotpro/services/GetPlayers.dart';
import 'package:hotpro/services/getPlayerFantasydata.dart';

class GameList extends StatefulWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  State<GameList> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  Fantasy_model? fantUser;
  GetPlayers gPlayers = GetPlayers();
  String name1 = '', name2 = '', name3 = '';
  int player1bid = 0, player2bid = 0, player3bid = 0;
  int teambid = 0;
  String error='';
  List<Player> allPlayers = [];
  List<Player> filteredPlayers1 = [];
  List<Player> filteredPlayers2 = [];
  List<Player> filteredPlayers3 = [];
  String url1='',url2='',url3='';

  TextEditingController player1Controller = TextEditingController();
  TextEditingController player2Controller = TextEditingController();
  TextEditingController player3Controller = TextEditingController();

  int plr1id = 0, plr2id = 0, plr3id = 0;

  FplPlayerdata p1fpldata = FplPlayerdata();
  FplPlayerdata p2fpldata = FplPlayerdata();
  FplPlayerdata p3fpldata = FplPlayerdata();

  Future<void> playersFantasydata(int plr1id, int plr2id, int plr3id) async {
    await p1fpldata.fetchPlayerData(plr1id);
    await p2fpldata.fetchPlayerData(plr2id);
    await p3fpldata.fetchPlayerData(plr3id);
  }

  @override
  void initState() {
    super.initState();
    gPlayers.fetchPlayers();
  }

  void _updatePlayer1Bid(int? value) {
    setState(() {
      player1bid = value ?? 0;
    });
  }

  void _updatePlayer2Bid(int? value) {
    setState(() {
      player2bid = value ?? 0;
    });
  }

  void _updatePlayer3Bid(int? value) {
    setState(() {
      player3bid = value ?? 0;
    });
  }

  void _updateTeamBid(int? value) {
    setState(() {
      teambid = value ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userinfo = Provider.of<Userinfo?>(context);
    final gamedata = Provider.of<QuerySnapshot<Object?>?>(context);

    if (userinfo == null) {
      return Center(child: Text('User info not available'));
    }

    if (gamedata == null) {
      return Center(child: CircularProgressIndicator());
    }

    for (var doc in gamedata.docs) {
      if (userinfo.userid == doc.id) {
        fantUser = Fantasy_model(
          Budget: doc['Budget'],
          profit: doc['profit'],
          username: doc['username'],
          teamid: doc['teamid'],
        );
        break;
      }
    }

    if (fantUser == null) {
      return Center(child: Text('No matching data found'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Card(
              color: Colors.orange[600],
              elevation: 5,
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Budget:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      '\$${fantUser?.Budget.toString() ?? '0'}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Player 1 Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            TextField(
              controller: player1Controller,
              decoration: text_input_dec.copyWith(hintText: "Search for a player"),
              onChanged: (val) {
                setState(() {
                  name1 = val;
                  gPlayers.filterPlayers(val);
                  filteredPlayers1 = gPlayers.filteredPlayers!;
                });
              },
            ),
            if (filteredPlayers1.isNotEmpty && name1.isNotEmpty)
              Container(
                height: 150,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: filteredPlayers1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredPlayers1[index].webName),
                      onTap: () async {
                        plr1id = filteredPlayers1[index].id;
                        await p1fpldata.fetchPlayerData(plr1id);
                        setState(() {
                          name1 = filteredPlayers1[index].webName;
                          url1 = filteredPlayers1[index].photoUrl;
                          player1Controller.text = name1;
                          filteredPlayers1.clear();
                        });
                      },
                    );
                  },
                ),
              ),
            if (name1.isNotEmpty && plr1id != 0)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(url1,width: 120,height: 120,),
                      Text(name1,style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 18),),
                      Text(
                        'Price: ${p1fpldata.price}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Ownership: ${p1fpldata.ownership}%',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('team position: ${p1fpldata.teamPosition}',style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text('Player 1 Bet:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            Container(
              constraints: BoxConstraints(maxHeight: 200),
              color: Colors.teal[50],
              child: PlayerDropMenu(onValueSelected: _updatePlayer1Bid),
            ),
            SizedBox(height: 20),
            Text('Player 2 Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            TextField(
              controller: player2Controller,
              decoration: text_input_dec.copyWith(hintText: "Search for a player"),
              onChanged: (val) {
                setState(() {
                  name2 = val;
                  gPlayers.filterPlayers(val);
                  filteredPlayers2 = gPlayers.filteredPlayers!;
                });
              },
            ),
            if (filteredPlayers2.isNotEmpty && name2.isNotEmpty)
              Container(
                height: 150,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: filteredPlayers2.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredPlayers2[index].webName),
                      onTap: () async {
                        plr2id = filteredPlayers2[index].id;
                        await p2fpldata.fetchPlayerData(plr2id);
                        setState(() {
                          name2 = filteredPlayers2[index].webName;
                          url2 = filteredPlayers2[index].photoUrl;
                          player2Controller.text = name2;
                          filteredPlayers2.clear();
                        });
                      },
                    );
                  },
                ),
              ),
            if (name2.isNotEmpty && plr2id != 0)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(url2,width: 120,height: 120,),
                      Text(name2,style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 18),),
                      Text(
                        'Price: ${p2fpldata.price}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Ownership: ${p2fpldata.ownership}%',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('team position: ${p2fpldata.teamPosition}',style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text('Player 2 Bet:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            Container(
              color: Colors.teal[50],
              child: PlayerDropMenu(onValueSelected: _updatePlayer2Bid),
            ),
            SizedBox(height: 20),
            Text('Player 3 Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            TextField(
              controller: player3Controller,
              decoration: text_input_dec.copyWith(hintText: "Search for a player"),
              onChanged: (val) {
                setState(() {
                  name3 = val;
                  gPlayers.filterPlayers(val);
                  filteredPlayers3 = gPlayers.filteredPlayers!;
                });
              },
            ),
            if (filteredPlayers3.isNotEmpty && name3.isNotEmpty)
              Container(
                height: 150,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: filteredPlayers3.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredPlayers3[index].webName),
                      onTap: () async {
                        plr3id = filteredPlayers3[index].id;
                        await p3fpldata.fetchPlayerData(plr3id);
                        setState(() {
                          name3 = filteredPlayers3[index].webName;
                          url3 = filteredPlayers3[index].photoUrl;
                          player3Controller.text = name3;
                          filteredPlayers3.clear();
                        });
                      },
                    );
                  },
                ),
              ),
            if (name3.isNotEmpty && plr3id != 0)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(url3,width: 120,height: 120,),
                      Text(name3,style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 18),),
                      Text(
                        'Price: ${p3fpldata.price}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Ownership: ${p3fpldata.ownership}%',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('team position: ${p3fpldata.teamPosition}',style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),


            SizedBox(height: 20),
            Text('Player 3 Bet:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            Container(
              color: Colors.teal[50],
              child: PlayerDropMenu(onValueSelected: _updatePlayer3Bid),
            ),
            SizedBox(height: 20),
            Text('Team Bet:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 8),
            Container(
              color: Colors.teal[50],
              child: Teamdrop(onValueSelected: _updateTeamBid),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 100),
              child: ElevatedButton.icon(
                onPressed: () async {
                  if(plr1id != 0 && plr2id != 0 && plr3id != 0 && player1bid != 0 && player2bid != 0 && player3bid != 0 && teambid != 0 && name1 != '' && name2 !='' && name3 != '')
                  {
                  //await playersFantasydata(plr1id, plr2id, plr3id);
                  final budget = fantUser!.Budget - player1bid - player2bid - player3bid - teambid;
                  DatabaseService(uid: userinfo.userid).updateUserData(
                    player1name: name1, player1bid: player1bid,player1id:  plr1id, p1ows:  p1fpldata.ownership,p1price:  p1fpldata.price,p1teampos:  p1fpldata.teamPosition,
                    player2name: name2,player2bid:  player2bid, player2id: plr2id, p2ows:  p2fpldata.ownership,p2price:  p2fpldata.price,p2teampos:  p2fpldata.teamPosition,
                    player3name: name3,player3bid:  player3bid,player3id:  plr3id, p3ows:  p3fpldata.ownership,p3price:  p3fpldata.price,p3teampos:  p3fpldata.teamPosition,
                    teambid: teambid, Budget: budget, play:  true,p1url:url1,p2url: url2,p3url: url3,
                  );
                  }
                  else
                  {
                     setState(() {
                       error = 'Something is missed!!';
                     });
                  }
                },
                icon: Icon(Icons.save),
                label: Text('Submit'),
              ),
            ),
            SizedBox(height: 10,),
            Padding(padding:EdgeInsets.only(left: 40),child: Text(error,style: TextStyle(color: Colors.yellow,fontSize: 22,fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}
