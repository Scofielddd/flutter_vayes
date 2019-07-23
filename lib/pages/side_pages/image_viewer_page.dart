import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerPage extends StatefulWidget {
  static String tag = 'image-viewer-page';
  final Uint8List photo;
  const ImageViewerPage({Key key,@required this.photo}) : super(key: key);

  @override
  _ImageViewerPageState createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PhotoView(
            imageProvider: MemoryImage(widget.photo),
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
            ],
          ),
        ),
      ],
    );
  }
}
