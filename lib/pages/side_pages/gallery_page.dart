import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/pages/side_pages/gallery_builder.dart';
import 'package:flutter_vayes/photo_bloc/photo.dart';

class GalleryPage extends StatelessWidget {
  static String tag = 'gallery-page';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
      builder: (context) => PhotoBloc(),
      child: GalleryBuilder(),
    );
  }
}