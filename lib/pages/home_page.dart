import 'package:flutter/material.dart';
import 'package:flutter_vayes/data/remote_api.dart';
import 'package:flutter_vayes/models/photo.dart';

import 'card_detail_page.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {

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

  /*Widget rowCard(BuildContext context, int index) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CardDetailPage(index)
              ),
            );
          },
          leading: Text("Head"),
          title: Text("Title"),
          subtitle: Text("Subsubsub"),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }*/
  
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
}}
