import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ required this.uid });

  //reference for my collection
  final CollectionReference fantasycollection = FirebaseFirestore.instance.collection("fantasy");



  //function to update data of the user
  Future updateUserData(String username,int teamid,String player1name , int player1bid ,int player1id,player1points,double p1ows,double p1price,int p1teampos, String player2name , int player2bid ,int player2id,player2points,double p2ows,double p2price,int p2teampos, String player3name ,int player3bid ,int player3id,player3points,double p3ows,double p3price,int p3teampos,int teambid,int GWprofit,int profit, int Budget , bool play)async{
    return fantasycollection.doc(uid).set({
      'username' : username,
      'player1' : player1name,
      'player2' : player2name,
      'player3' : player3name,
      'player1bid' : player1bid,
      'player2bid' : player2bid,
      'player3bid' : player3bid,
      'player1id': player1id,
      'player2id': player2id,
      'player3id':player3id,
      'player1points':player1points,
      'player2points': player2points,
      'player3points': player3points,
      'player1ows' : p1ows,
      'player2ows' : p2ows,
      'player3ows' : p3ows,
      'player1price' : p1price,
      'player2price' : p2price,
      'player3price' : p3price,
      'player1 team position' : p1teampos,
      'player2 team position' : p2teampos,
      'player3 team position' : p3teampos,
      'teambid' : teambid,
      'profit' : profit,
      'Budget' : Budget,
      'play' : play,
      'teamid': teamid,
      'GWprofit': GWprofit,

    });
  }

  Stream<QuerySnapshot?> get fandata {
    return fantasycollection.snapshots();
  }

  CollectionReference emer (){
    return fantasycollection;
  }
}