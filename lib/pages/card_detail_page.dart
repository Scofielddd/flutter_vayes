import 'package:flutter/material.dart';
import 'package:flutter_vayes/models/photo.dart';

class CardDetailPage extends StatelessWidget {
  static String tag = 'card-detail-page';

  Photo photo;
  CardDetailPage(photo){
    this.photo = photo;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        primary: true,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                photo.url
              ),
            ),
            floating: false,
            pinned: false,
            primary: true,
            title: Text(this.photo.title),
          ),


          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(photo.title),
                  Image.network(
                    photo.url
                  ),
                  Image.network(
                    photo.thumbnailUrl
                  ),
                  Text("Album ID :"+photo.albumId.toString()),
                  Text("Photo ID :"+photo.id.toString()),
                  Text(photo.title),
                  Image.network(
                      photo.url
                  ),
                  Image.network(
                      photo.thumbnailUrl
                  ),
                  Text("Album ID :"+photo.albumId.toString()),
                  Text("Photo ID :"+photo.id.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
