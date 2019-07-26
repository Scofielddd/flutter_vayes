import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vayes/pages/home_page.dart';
import 'package:flutter_vayes/pages/public/class_builder.dart';
import 'package:flutter_vayes/pages/side_pages/account_page.dart';
import 'package:flutter_vayes/pages/side_pages/gallery_page.dart';
import 'package:flutter_vayes/photo_bloc/photo_page.dart';
import 'package:kf_drawer/kf_drawer.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('HomePage'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text(
            'Durum İzleme',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          page: HomePage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Hesabım',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.calendar_today, color: Colors.white),
          page: AccountPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Galeri',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.photo_library, color: Colors.white),
          page: GalleryPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Medya Ekle',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.calendar_today, color: Colors.white),
          page: PhotoPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Hesap Ayarlarım',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          //page: ClassBuilder.fromString('PhotoPage'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return KFDrawer(
          controller: _drawerController,
          borderRadius: 10.0,
          //shadowBorderRadius: 20.0,
          menuPadding: EdgeInsets.all(30.0),
          scrollable: false,
          header: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).orientation == Orientation.landscape
                  ? MediaQuery.of(context).size.width * 0.4
                  : MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(
                'assets/vayes_logo.png',
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          footer: KFDrawerItem(
            text: Text(
              'Çıkış',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) {
                  return PhotoPage();
                },
              ));
            },
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(255, 255, 255, 1.0),
                Color.fromRGBO(44, 72, 171, 1.0)
              ],
              tileMode: TileMode.repeated,
            ),
          ),
        );
      }),
    );
  }
}
