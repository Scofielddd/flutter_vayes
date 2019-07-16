import 'package:flutter/material.dart';
import 'package:flutter_vayes/pages/public/drawer_dynamic.dart';
import 'package:flutter_vayes/pages/side_pages/image_viewer_page.dart';

class GalleryPage extends StatefulWidget {
  static String tag = 'gallery-page';
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  List<Widget> _buildGridTiles(numberOfTiles) {
    List<GestureDetector> containers =
        new List<GestureDetector>.generate(numberOfTiles, (int index) {
      //index = 0, 1, 2,...
      final imageName = index < 9
          ? 'assets/vayes_logo.png'
          : 'assets/vayes_logo.png';
      return new GestureDetector(
        onTap: (){
          print(imageName);
          Navigator.push(context,MaterialPageRoute(builder: (context) => ImageViewerPage()));
        },
              child: new Container(
          child: new Image.asset(imageName, fit: BoxFit.fill),
        ),
      );
    });
    return containers;
  }

  @override
  Widget build(BuildContext context) {
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
}
