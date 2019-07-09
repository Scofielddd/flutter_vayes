
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/data/user/user_repository.dart' ;

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
          IconButton(
            icon: Icon(Icons.settings, color: Colors.blue,),
            tooltip: 'Menu',
            onPressed: null,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 54.0,
                    child: Image.asset('assets/vayes_logo.png'),
                  ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box,color: Colors.blue,),
              title: Text('Hesabım'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_a_photo, color: Colors.blue,),
              title: Text('Medya Ekle'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.perm_media, color: Colors.blue,),
              title: Text('Galerim'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.scatter_plot, color: Colors.blue,),
              title: Text('Hesap Ayalarım'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              isThreeLine: true,
              subtitle: Text("username"),
              contentPadding: EdgeInsets.only(top: 50, left: 20),
              title: Text("Çıkış"),
              leading: Icon(Icons.exit_to_app, color: Colors.blue),
              onTap: (){
                Navigator.pop(context);
                authenticationBloc.dispatch(LoggedOut());
              },
            ),
            
            
          ],
        ),
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
                UserRepository ur = new UserRepository();
                ur.checkAuthorization().then((x) => setState((){
                  print(x.toString());
                  if(x.toString() == "false")
                  {
                    testText = "You have not permission"; 
                  }
                  else
                    testText = "You have permission";
                }));
              },
            ),
            Text(testText),
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
