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
        child: ListView(
          children: <Widget>[
            Text(
                        'vayes prime',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 70,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontFamily: ("Playlines"),
                            color: Color(0xff1b76b9)),
                      ),
            /*CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 90.0,
                    child: Image.asset('assets/vayes_logo.png'),
                  ),*/
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(),
              )
            ),
          ],
        ),
      ));
}
