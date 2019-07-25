import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/photo_bloc/photo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerPage extends StatefulWidget {
  static String tag = 'image-viewer-page';
  final Uint8List photo;
  final PhotoBloc photoBloc;
  const ImageViewerPage(
      {Key key, @required this.photo, @required this.photoBloc})
      : super(key: key);

  @override
  _ImageViewerPageState createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  bool stateCrop = false;
  File croppedFileGlob;
  Future<String> _getPath(Uint8List bytes) async {
    String dir = (await getTemporaryDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: await _getPath(widget.photo),
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
    );
    if (croppedFile != null) {
      print("image cropped and changed");
      setState(() {
        stateCrop = true;
      });
      croppedFileGlob = croppedFile;
      print(stateCrop);
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
        content: Text('Fotoğraf başarıyla yüklendi!'),
        action: SnackBarAction(
          label: 'Kapat',
          onPressed: () {
            // Some code to undo the change.
          },
        ));
    return new Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Expanded(
            child: PhotoView(
              imageProvider: croppedFileGlob != null
                  ? AssetImage(croppedFileGlob.path)
                  : MemoryImage(widget.photo),
              minScale: PhotoViewComputedScale.contained * 0.8,
              // Covered = the smallest possible size to fit the whole screen
              maxScale: PhotoViewComputedScale.covered * 2,
              enableRotation: true,
              // Set the background color to the "classic white"
              backgroundDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              loadingChild: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Container(
            color: Theme.of(context).canvasColor,
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                RaisedButton(
                  child: Icon(Icons.crop),
                  onPressed: () {
                    _cropImage();
                  },
                ),
                stateCrop == true
                    ? RaisedButton(
                        child: Icon(Icons.file_upload),
                        onPressed: () async {
                          widget.photoBloc.dispatch(PhotoUploadPressed(
                              photo: croppedFileGlob.path, photoName: "1"));
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                          await new Future.delayed(const Duration(seconds: 2));
                          Navigator.pop(context);
                        })
                    : null,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
