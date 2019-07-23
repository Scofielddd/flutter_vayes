import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vayes/pages/side_pages/take_photo.dart';
import 'package:flutter_vayes/photo_bloc/photo.dart';

class PhotoPage extends StatelessWidget {
  static String tag = 'photo-page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoBloc>(
      builder: (context) => PhotoBloc(),
      child: TakePhoto(),
    );
  }
}
