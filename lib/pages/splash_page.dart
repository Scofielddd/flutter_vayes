import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          child:  Image.asset("assets/vayes_logo.png"),
        ),
      ),
    );
  }
}
