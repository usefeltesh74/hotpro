import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotpro/screens/home/resultList.dart';
import 'package:provider/provider.dart';

import '../../models/fantasydata_model.dart';
import '../../models/user_model.dart';
import 'Gamelist.dart';

class PlayOrNot extends StatelessWidget {
    PlayOrNot({super.key});
  Fantasy_model? fantUser;
  @override
  Widget build(BuildContext context) {
    final userinfo = Provider.of<Userinfo?>(context);
    final gamedata = Provider.of<QuerySnapshot<Object?>?>(context);


    if (gamedata == null) {
      return Center(child: CircularProgressIndicator());
    }

    for( var doc in gamedata.docs)
    {
      if(userinfo?.userid == doc.id)
      {
        fantUser = Fantasy_model(
          play: doc['play'],
        );
      }
    }

    return fantUser?.play == false ? GameList() : Resultlist();
  }
}
