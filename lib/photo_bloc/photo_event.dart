import 'dart:io';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  PhotoEvent([List props = const []]) : super(props);
}

class PhotoUploadPressed extends PhotoEvent{
  final String photoName;
  final String photo;

  PhotoUploadPressed({
    @required this.photoName,
    @required this.photo
  }) : super([photoName,photo]); 

  @override
  String toString() =>
      'UploadButtonPressed { photoName: $photoName, photo: $photo }';
}