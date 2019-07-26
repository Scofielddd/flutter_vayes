import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/pages/side_pages/gallery_builder.dart';
import 'package:flutter_vayes/photo_bloc/photo.dart';
import 'package:kf_drawer/kf_drawer.dart';

class GalleryPage extends KFDrawerContent {
  static String tag = 'gallery-page';
  @override
  _GalleryPageState createState() => _GalleryPageState();

  static _GalleryPageState of(BuildContext context) {
    final _GalleryPageState navigator =
        context.ancestorStateOfType(const TypeMatcher<_GalleryPageState>());

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

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
      builder: (context) => PhotoBloc(),
      child: GalleryBuilder(),
    );
  }
}