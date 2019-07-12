import 'package:flutter/material.dart';
import 'package:flutter_vayes/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ApplicationSettingsIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings, color: Colors.blue),
      tooltip: 'Settings',
      onPressed: null,
    );
  }
}

class DrawerDynamic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return new Drawer(
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: DrawerHeader(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 100.0,
                    child: Image.asset('assets/vayes_logo.png'),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                  ),
                ),
              ),
              Container(
                height: 1.5,
                color: Colors.black26,
              ),
              Container(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  title: Text('Anasayfa'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'home-page');
                  },
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(
                    Icons.account_box,
                    color: Colors.blue,
                  ),
                  title: Text('Hesabım'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'account-page');
                  },
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(
                    Icons.add_a_photo,
                    color: Colors.blue,
                  ),
                  title: Text('Medya Ekle'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'take-photo-page');
                  },
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(
                    Icons.perm_media,
                    color: Colors.blue,
                  ),
                  title: Text('Galerim'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, "gallery-page");
                  },
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: ListTile(
                  leading: Icon(
                    Icons.scatter_plot,
                    color: Colors.blue,
                  ),
                  title: Text('Hesap Ayalarım'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                height: 1.5,
                color: Colors.black26,
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        //isThreeLine: true,
                        subtitle: Text("username"),
                        //contentPadding: EdgeInsets.only(top: 50, left: 20),

                        title: Text("Çıkış"),
                        leading: Icon(Icons.exit_to_app, color: Colors.red),
                        onTap: () {
                          Navigator.pop(context);
                          authenticationBloc.dispatch(LoggedOut());
                        },
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
  }
}

class Fab extends StatefulWidget {
  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
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
            onTap: () => print('Kamerayı Kullan')),
        SpeedDialChild(
          child: Icon(Icons.image),
          label: 'Galeriden Getir',
          labelStyle: TextStyle(fontSize: 10.0),
          onTap: () => print('Galeriyi Kullan'),
        ),
      ],
    );
  }
}
