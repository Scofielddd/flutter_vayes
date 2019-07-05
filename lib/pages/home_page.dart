import 'package:flutter/material.dart';
import 'package:flutter_vayes/data/remote_api.dart';
import 'package:flutter_vayes/models/photo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'card_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_vayes/authentication/authentication.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();
   final uri = "http://10.0.2.2:50567/api";


  Future<bool> checkAuthorization() async {
      String readToken =await storage.read(key: "jwt");
      var response = await http.get(Uri.encodeFull(uri+"/values/get/1"),
      headers: {"Content-Type": "application/json",
        "Authorization":"Bearer "+ readToken}
      );
      if(response.statusCode != 200)
      {
        print(response.statusCode);
        return false;
      }
      else
      {
        print(response.statusCode);
        return true;
      }
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: Column(children: <Widget>[
            RaisedButton(
              child: Text('logout'),
              onPressed: () {
                authenticationBloc.dispatch(LoggedOut());
            }),
            RaisedButton(
              child: Text("getlist"),
              onPressed: (){
                checkAuthorization();
              },
            )
          ],
          )
        )
            
      ),
    );
  }
}


/*class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: null,
          ),
        ],
      ),
      body: getList(),
    );
  }

  Widget getList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return rowCard(context, index);
      },
      itemCount: 20,
    );
  }

  
  Widget rowCard(BuildContext context, int index) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(future: getPhoto(index+1),builder: (BuildContext context, AsyncSnapshot<Photo> snapshot){
        if(snapshot.hasData){
          return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CardDetailPage(snapshot.data)
              ),
            );
          },
          leading: Text(snapshot.data.id.toString()),
          title: Text(snapshot.data.title),
          subtitle: Image.network(
            snapshot.data.thumbnailUrl,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      }),
      ),
    );
}}*/
