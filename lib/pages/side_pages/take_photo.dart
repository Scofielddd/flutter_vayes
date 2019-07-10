import 'package:flutter/material.dart';
import 'package:flutter_vayes/pages/drawer_dynamic.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TakePhoto extends StatefulWidget {
  static String tag ='take-photo-page';
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    //var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medya Ekle'),
        iconTheme: new IconThemeData(color: Colors.blue),
        actions: <Widget>[
          ApplicationSettingsIcon(),
        ],
      ),
      drawer: DrawerDynamic(),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_arrow,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          child: Icon(Icons.add_a_photo),
          visible: true,
          // If true user is forced to close dial manually 
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.1,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.photo_camera),
              label: 'Kameradan Çek',
              labelStyle: TextStyle(fontSize: 10.0),
              onTap: () => getImage(),
            ),
            SpeedDialChild(
              child: Icon(Icons.image),
              label: 'Galeriden Getir',
              labelStyle: TextStyle(fontSize: 10.0),
              onTap: () => getImageGallery(),
            ),
          ],
        ),
    );
  }
}