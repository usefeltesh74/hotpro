import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading_screen extends StatelessWidget {
  const Loading_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.indigo[800],
          body: Center(
            child: SpinKitHourGlass(
              color: Colors.orange,
              size: 100.0,
            ),
          )


      ),
    );
  }
}
