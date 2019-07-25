import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/pages/public/drawer_dynamic.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_vayes/photo_bloc/photo.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter/services.dart';

class TakePhoto extends StatefulWidget {
  static String tag = 'take-photo-page';
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      File compressedFile =
          await FlutterNativeImage.compressImage(image.path, quality: 50);
      setState(() {
        _image = compressedFile;
      });
      _cropImage();
    }
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File compressedFile =
          await FlutterNativeImage.compressImage(image.path, quality: 50);
      setState(() {
        _image = compressedFile;
      });
      _cropImage();
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
    );
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
      print("image cropped and changed");
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final _photoBloc = BlocProvider.of<PhotoBloc>(context);
    final snackBar = SnackBar(
        content: Text('Fotoğraf başarıyla yüklendi!'),
        action: SnackBarAction(
          label: 'Kapat',
          onPressed: () {
            // Some code to undo the change.
          },
        ));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Medya Ekle'),
        iconTheme: new IconThemeData(color: Colors.blue),
        actions: <Widget>[
          ApplicationSettingsIcon(),
        ],
      ),
      drawer: DrawerDynamic(),
      body: Center(
        child: BlocBuilder(
          bloc: _photoBloc,
          builder: (context, PhotoState state) {
            if (_image != null) {
              _photoBloc.dispatch(PhotoSelected());
            }
            if (state is PhotoUploadLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PhotoUploadInitial) {
              return Text('Fotoğraf seçilmedi');
            } else if (state is PhotoUploadLoaded) {
              _image = null;
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Scaffold.of(context).showSnackBar(snackBar));
              return Text("sa");
            } else if (state is PhotoUploadFailure) {
              return Center(
                child: Text("Hata :" + state.error),
              );
            } else if (state is PhotoUploadSelected) {
              if (_image == null) {
                return Text("Fotoğraf seçilmedi");
              } else {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              constraints:
                                  BoxConstraints(maxHeight: height * 2 / 3),
                              child: Image.file(_image))),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("crop button pressed");
                                  if (_image != null)
                                    _cropImage();
                                  else
                                    print("_image is null");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 45.0,
                                    decoration: new BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black,
                                          offset: new Offset(20.0, 10.0),
                                          blurRadius: 30.0,
                                        )
                                      ],
                                    ),
                                    child: new Text(
                                      "Kes",
                                      style: new TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  print("upload pressed");
                                  _photoBloc.dispatch(PhotoUploadPressed(
                                      photo: _image.path,
                                      photoName: 'photos/u' +
                                          new DateTime.now().toIso8601String() +
                                          '.jpg'));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 45.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.black,
                                            offset: new Offset(20.0, 10.0),
                                            blurRadius: 20.0,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0),
                                              child: Text(
                                                "Yükle",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.file_upload,
                                            color: Colors.white,
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              return Text("Veri bulunamadı");
            }
          },
        ),
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
            onTap: () {
              getImageGallery();
            },
          ),
        ],
      ),
    );
  }
}
