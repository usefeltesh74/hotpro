import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ required this.uid });

  //reference for my collection
  final CollectionReference fantasycollection = FirebaseFirestore.instance.collection("fantasy");



  //function to update data of the user
  Future updateUserData(String username,String player1name , int player1bid ,int player1id,player1points, String player2name , int player2bid ,int player2id,player2points, String player3name ,int player3bid ,int player3id,player3points,int teambid,int profit, int Budget , bool play)async{
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
      'teambid' : teambid,
      'profit' : profit,
      'Budget' : Budget,
      'play' : play,
    });
  }

  Stream<QuerySnapshot?> get fandata {
    return fantasycollection.snapshots();
  }

  CollectionReference emer (){
    return fantasycollection;
  }
}