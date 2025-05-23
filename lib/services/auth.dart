import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotpro/models/user_model.dart';
import 'package:hotpro/services/Cloud%20firestore.dart';

class fireauth
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String NameOfUser='';
  Userinfo? _userfromfirebaseuser(User? user)
  {

    if(user != null)
      {
        return Userinfo(userid: user.uid);
      }
    else
      {
        return null;
      }
  }

  // stream authenticate status
  Stream<Userinfo?> get status
  {
    return _auth.authStateChanges()
        .map((User? user) => _userfromfirebaseuser(user)) ;// Map User? to Userinfo?
        //.where((userInfo) => userInfo != null)// Filter out nulls
        //.cast<Userinfo>();

  }
  //sing in anonymous
  // Future signin_anon() async
  // {
  //   try{
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     Userinfo? userdata = _userfromfirebaseuser(user);
  //     return userdata;
  //
  //   }
  //   catch(e)
  //   {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Sign up with email and password

  Future Signup_with_email_and_password(String email , String password,String username,int teamid)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(username: username,teamid: teamid,GW: 0,stand_GW: 0,stand_player1: '',stand_player2: '',stand_player3: '',stand_player1bet: 0,stand_player2bet: 0,stand_player3bet: 0,player1profit: 0,player2profit: 0,player3profit: 0,profit: 0,GWprofit: 0,Budget:  1000000 ,play: false);
      return _userfromfirebaseuser(user);
    }
    catch(e){
      print(e.toString());

      return null;
    }

  }

  //sign in with email and password
  Future Signin_with_email_and_password(String email , String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromfirebaseuser(user);
    }
    catch(e){
      print(e.toString());

      return null;
    }

  }


  //sign out
 Future Sign_out() async
 {
   try{
     return _auth.signOut();
   }
   catch(e)
   {
     print(e.toString());
     return null;
   }
 }


}