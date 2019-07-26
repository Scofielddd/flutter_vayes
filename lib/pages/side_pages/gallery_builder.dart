import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/pages/public/drawer_dynamic.dart';
import 'package:flutter_vayes/pages/side_pages/gallery_page.dart';
import 'package:flutter_vayes/pages/side_pages/image_viewer_page.dart';
import 'package:flutter_vayes/photo_bloc/photo.dart';
import 'package:kf_drawer/kf_drawer.dart';

class GalleryBuilder extends KFDrawerContent {
  GalleryBuilder({
    Key key,
  });
  @override
  _GalleryBuilderState createState() => _GalleryBuilderState();
}

class _GalleryBuilderState extends State<GalleryBuilder> {
  List<Uint8List> photosList(List<DocumentSnapshot> lastPhotos) {
    List<Uint8List> list = [];
    try {
      for (var item in lastPhotos) {
        Uint8List decoded = base64Decode(item.data['base64']);
        list.add(decoded);
      }
    } catch (e) {
      print(e);
    }
    List<Uint8List> reversedList = new List(list.length);
    for (int i = 0; i < list.length; i++) {
      reversedList[i] = list[list.length - i - 1];
    }
    list = null;
    return reversedList;
  }

  @override
  Widget build(BuildContext context) {
    final _photoBloc = BlocProvider.of<PhotoBloc>(context);
    _photoBloc.dispatch(PhotosGetPressed(userGuid: "sda"));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Galerim'),
        iconTheme: new IconThemeData(color: Colors.blue),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Function x =GalleryPage.of(context).widget.onMenuPressed;
              x();
            },
          ),
          ApplicationSettingsIcon(),
        ],
      ),
      //drawer: DrawerDynamic(),
      body: Center(
        child: BlocBuilder(
          bloc: _photoBloc,
          builder: (context, PhotoState state) {
            if (state is PhotoGetInitial || state is PhotoUploadInitial) {
              return Center(
                child: Text("Lütfen fotoğraf yükleyiniz"),
              );
            } else if (state is PhotoGetLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PhotoGetLoaded) {
              final lastPhotos = state.photos;
              for (var item in lastPhotos) {
                print(item.data);
              }
              List<Uint8List> list = photosList(lastPhotos);

              return (GridView.extent(
                maxCrossAxisExtent: 150.0,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                padding: const EdgeInsets.all(5.0),
                children: List.generate(list.length, (index) {
                  return new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageViewerPage(
                                    photo: list[index],
                                    photoBloc: _photoBloc,
                                  )));
                    },
                    child: new Container(
                      child:
                          new Image.memory(list[index], fit: BoxFit.fitWidth),
                    ),
                  );
                }), //Where is this function ?
              ));
            } else {
              return Text("Sunucu hatası");
            }
          },
        ),
      ),
    );
  }
}

/*class GalleryBuilder extends StatefulWidget {
  @override
  _GalleryBuilderState createState() => _GalleryBuilderState();
}

class _GalleryBuilderState extends State<GalleryBuilder> {
  @override
  Widget build(BuildContext context) {
    final _photoBloc = BlocProvider.of<PhotoBloc>(context);

    _getPhotos(_photoBloc);

    return Scaffold(
      appBar: AppBar(
        title: Text('Galerim'),
        iconTheme: new IconThemeData(color: Colors.blue),
        actions: <Widget>[
          ApplicationSettingsIcon(),
        ],
      ),
      drawer: DrawerDynamic(),
      body: GridView.extent(
        maxCrossAxisExtent: 150.0,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        padding: const EdgeInsets.all(5.0),
        children: _buildGridTiles(10), //Where is this function ?
      ),
    );
  }

  List<Uint8List> _getPhotos(PhotoBloc _photoBloc) {
    _photoBloc.dispatch(PhotosGetPressed(userGuid: "sadqguid"));

    return null;
  }

  List<Widget> _buildGridTiles(numberOfTiles) {
    List<GestureDetector> containers =
        new List<GestureDetector>.generate(numberOfTiles, (int index) {
      //index = 0, 1, 2,...

      return new GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImageViewerPage()));
        },
        child: new Container(
          child: new Image.asset("assets/vayes_logo.png", fit: BoxFit.fitWidth),
        ),
      );
    });
    return containers;
  }
}*/
