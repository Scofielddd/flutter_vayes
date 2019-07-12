import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/pages/drawer_dynamic.dart';
import 'package:flutter_vayes/authentication/authentication.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();
  String testText = "";

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        iconTheme: new IconThemeData(color: Colors.blue),
        actions: <Widget>[
          ApplicationSettingsIcon(),
        ],
      ),
      drawer: DrawerDynamic(),
      body: Container(
          child: Center(
              child: Column(
        children: <Widget>[
          
          
          


          /*
          //check authorization
          RaisedButton(
            child: Text("getlist"),
            onPressed: () {
              UserRepository ur = new UserRepository();
              ur.checkAuthorization().then((x) => setState(() {
                    print(x.toString());
                    if (x.toString() == "false") {
                      testText = "You have not permission";
                    } else
                      testText = "You have permission";
                  }));
            },
          ),*/
          Text(testText),
        ],
      ))),
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
