import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Color(0xFF18D191)),
      ),
      body:Center(
        //width: double.infinity,
        child: Column(
          children: <Widget>[
            CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 90.0,
                    child: Image.asset('assets/vayes_logo.png'),
                  ),
            CircularProgressIndicator(),
          ],
        ),
      ));
}
