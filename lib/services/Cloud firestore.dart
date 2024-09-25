import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ required this.uid });

  //reference for my collection
  final CollectionReference fantasycollection = FirebaseFirestore.instance.collection("fantasy");



  //function to update data of the user
  Future<void> updateUserData({
    String? username, int? teamid,int? GW,int? stand_GW, String? stand_player1, int? stand_player1bet,
    int? player1profit, String? stand_player2, int? stand_player2bet, int? player2profit,
    String? stand_player3, int? stand_player3bet, int? player3profit, String? player1name,
    int? player1bid, int? player1id,String? p1url, int? player1points, double? p1ows, double? p1price,
    int? p1teampos, String? player2name, int? player2bid, int? player2id,String? p2url, int? player2points,
    double? p2ows, double? p2price, int? p2teampos, String? player3name, int? player3bid,
    int? player3id,String? p3url, int? player3points, double? p3ows, double? p3price, int? p3teampos,
    int? teambid, int? GWprofit, int? profit, int? Budget, bool? play
  }) async {
    Map<String, dynamic> updates = {};

    // Add only non-null fields to the updates map
    if (username != null) updates['username'] = username;
    if (teamid != null) updates['teamid'] = teamid;
    if (stand_player1 != null) updates['stand_player1'] = stand_player1;
    if (stand_player1bet != null) updates['stand_player1bet'] = stand_player1bet;
    if (player1profit != null) updates['player1profit'] = player1profit;
    if (stand_player2 != null) updates['stand_player2'] = stand_player2;
    if (stand_player2bet != null) updates['stand_player2bet'] = stand_player2bet;
    if (player2profit != null) updates['player2profit'] = player2profit;
    if (stand_player3 != null) updates['stand_player3'] = stand_player3;
    if (stand_player3bet != null) updates['stand_player3bet'] = stand_player3bet;
    if (player3profit != null) updates['player3profit'] = player3profit;
    if (player1name != null) updates['player1'] = player1name;
    if (player1bid != null) updates['player1bid'] = player1bid;
    if (player1id != null) updates['player1id'] = player1id;
    if (player1points != null) updates['player1points'] = player1points;
    if (p1ows != null) updates['player1ows'] = p1ows;
    if (p1price != null) updates['player1price'] = p1price;
    if (p1teampos != null) updates['player1 team position'] = p1teampos;
    if (player2name != null) updates['player2'] = player2name;
    if (player2bid != null) updates['player2bid'] = player2bid;
    if (player2id != null) updates['player2id'] = player2id;
    if (player2points != null) updates['player2points'] = player2points;
    if (p2ows != null) updates['player2ows'] = p2ows;
    if (p2price != null) updates['player2price'] = p2price;
    if (p2teampos != null) updates['player2 team position'] = p2teampos;
    if (player3name != null) updates['player3'] = player3name;
    if (player3bid != null) updates['player3bid'] = player3bid;
    if (player3id != null) updates['player3id'] = player3id;
    if (player3points != null) updates['player3points'] = player3points;
    if (p3ows != null) updates['player3ows'] = p3ows;
    if (p3price != null) updates['player3price'] = p3price;
    if (p3teampos != null) updates['player3 team position'] = p3teampos;
    if (teambid != null) updates['teambid'] = teambid;
    if (GWprofit != null) updates['GWprofit'] = GWprofit;
    if (profit != null) updates['profit'] = profit;
    if (Budget != null) updates['Budget'] = Budget;
    if (play != null) updates['play'] = play;
    if(stand_GW != null) updates['stand_GW'] = stand_GW;
    if(GW != null) updates['GW'] = GW;
    if(p1url != null) updates['p1url'] = p1url;
    if(p2url != null) updates['p2url'] = p2url;
    if(p3url != null) updates['p3url'] = p3url;
    // Update the Firestore document
    if (updates.isNotEmpty) {
      await fantasycollection.doc(uid).set(updates, SetOptions(merge: true));
    }
  }


  Stream<QuerySnapshot?> get fandata {
    return fantasycollection.snapshots();
  }

  CollectionReference emer (){
    return fantasycollection;
  }
}