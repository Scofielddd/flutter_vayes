import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/pages/side_pages/take_photo.dart';
import 'package:flutter_vayes/photo_bloc/photo.dart';
import 'package:kf_drawer/kf_drawer.dart';

class PhotoPage extends KFDrawerContent {
  PhotoPage({
    Key key,
  });
  static String tag = 'photo-page';
  @override
  _PhotoPageState createState() => _PhotoPageState();

  static _PhotoPageState of(BuildContext context) {
    final _PhotoPageState navigator =
        context.ancestorStateOfType(const TypeMatcher<_PhotoPageState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError(
            'MyStatefulWidgetState operation requested with a context that does '
            'not include a MyStatefulWidget.');
      }
      return true;
    }());

    return navigator;
  }
}

class _PhotoPageState extends State<PhotoPage> {
  GlobalKey myKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
      builder: (context) => PhotoBloc(),
      child:new TakePhoto(),
    );
  }
}

/*
class PhotoPage extends KFDrawerContent {
  PhotoPage({
    Key key,
  });
  static String tag = 'photo-page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
      builder: (context) => PhotoBloc(),
      child:new TakePhoto(),
    );
  }
}*/
