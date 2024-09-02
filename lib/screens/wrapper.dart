import 'package:flutter/material.dart';
import 'package:hotpro/models/user_model.dart';
import 'package:hotpro/screens/authenticate/authenticate.dart';
import 'package:hotpro/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user_info = Provider.of<Userinfo?>(context);
    //print(user_info);
    if(user_info != null) {
      return home();
    }
    else{
      return authenticate();
    }
  }
}
