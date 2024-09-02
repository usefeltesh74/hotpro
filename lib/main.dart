import 'package:flutter/material.dart';
import 'package:hotpro/models/user_model.dart';
import 'package:hotpro/screens/authenticate/authenticate.dart';
import 'package:hotpro/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotpro/screens/wrapper.dart';
import 'package:hotpro/services/auth.dart';
import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userinfo?>.value(
      initialData: null,
      value: fireauth().status,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
