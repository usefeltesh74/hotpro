import 'package:flutter/material.dart';
import 'package:hotpro/screens/authenticate/register.dart';
import 'package:hotpro/screens/authenticate/sign_in.dart';

class authenticate extends StatefulWidget {
  const authenticate({super.key});

  @override
  State<authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  @override

  bool showsignin = true;
  void toggleview()
  {
    setState(() => showsignin = !showsignin);
  }

  Widget build(BuildContext context) {
    return showsignin ? sign_in(toggleview: toggleview) : register(toggleview : toggleview);
  }
}
