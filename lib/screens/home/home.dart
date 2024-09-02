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
        backgroundColor: Colors.orange[300],
          appBar: AppBar(
            //leading: Image.asset("assets/12-121809_premier-league-white-logo-hd-png-download.png"),
            title: Text("FantasyXbet", style: TextStyle(fontWeight: FontWeight.bold),),
            //centerTitle: true,
            backgroundColor: Colors.orange,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.logout),
                  label: Text("Log out"),
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

            ],
          ),

          body: PlayOrNot(),
      ),
    );
  }
}
