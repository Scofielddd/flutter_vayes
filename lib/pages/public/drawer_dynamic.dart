import 'package:flutter/material.dart';
import 'package:flutter_vayes/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_vayes/data/user/user_repository.dart';
import 'package:flutter_vayes/pages/home_page.dart';
import 'package:flutter_vayes/pages/login/login_page.dart';

class ApplicationSettingsIcon extends StatelessWidget {
  final Color blueFont = Color(0xff1b76b9);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings, color: blueFont),
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
    final Color blueFont = Color(0xff1b76b9);
    return new Drawer(
      child: Padding(
        padding: EdgeInsets.zero,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: DrawerHeader(
                      child:
                          /*CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 100.0,
                        child: Image.asset('assets/vayes_logo.png'),
                      ),*/
                          Text(
                        'prime',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 80,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontFamily: ("Playlines"),
                            color: blueFont),
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
                        color: blueFont,
                      ),
                      title: Text('Anasayfa'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,new MaterialPageRoute(builder: (context) => new HomePage()));
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Icon(
                        Icons.account_box,
                        color: blueFont,
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
                        color: blueFont,
                      ),
                      title: Text('Medya Ekle'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, 'take-photo-page');
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Icon(
                        Icons.perm_media,
                        color: blueFont,
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
                        color: blueFont,
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
                ],
              ),
            ),
            MediaQuery.of(context).orientation == Orientation.landscape
                ? SliverToBoxAdapter(
                    child: Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        //isThreeLine: true,
                        subtitle: Text("username"),
                        //contentPadding: EdgeInsets.only(top: 50, left: 20),

                        title: Text("Çıkış"),
                        leading: Icon(Icons.exit_to_app, color: Colors.red),
                        onTap: () {
                          
                          authenticationBloc.dispatch(LoggedOut());
                        },
                      ),
                    ),
                  )
                : SliverFillRemaining(
                    hasScrollBody: false,
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
                            Navigator.pushReplacement(context,new MaterialPageRoute(builder: (context) => new LoginPage(userRepository: UserRepository(),)));
                            
                          },
                        ),
                      ),
                    ),
                  )
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
