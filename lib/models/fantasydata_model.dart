import 'dart:ffi';

class Fantasy_model {
  String username;
  int teamid;
  String player1;
  int player1bid;
  int player1id;
  int player2id;
  int player3id;
  int player1points;
  String player2;
  int player2bid;
  int player2points;
  String player3;
  int player3bid;
  int player3points;
  int Gwbiid;
  int Budget;
  int GWprofit;
  int profit;
  bool play;
  Fantasy_model({this.username='',this.teamid=0,this.player1='',this.player1bid=0,this.player1id=0,this.player1points=0,this.player2='',this.player2bid=0,this.player2id=0,this.player2points=0,this.player3='',this.player3bid=0,this.player3id=0,this.player3points=0,this.Gwbiid=0,this.Budget=0,this.GWprofit=0,this.profit=0,this.play=false});
}