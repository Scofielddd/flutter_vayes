import 'package:flutter/material.dart';
import 'package:flutter_vayes/pages/public/drawer_dynamic.dart';

class AccountPage extends StatefulWidget {
  static String tag = 'account-page';
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Hesabım'),
        iconTheme: new IconThemeData(color: Colors.blue),
        actions: <Widget>[
          ApplicationSettingsIcon(),
        ],
      ),
      drawer: DrawerDynamic(),
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
            
            Text("Hesabım"),
          ],
          )
        )
            
      ),
    );
  }
}