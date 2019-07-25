import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PhotoState extends Equatable {
  PhotoState([List props = const []]) : super(props);
}

class PhotoUploadInitial extends PhotoState{
  @override
  String toString() => 'PhotoUploadInitial';
}

class PhotoUploadSelected extends PhotoState{
  @override
  String toString() => 'PhotoUploadSelected';
}

class PhotoUploadLoading extends PhotoState{
  @override
  String toString() => 'PhotoUploadLoading';
}

class PhotoUploadLoaded extends PhotoState{
  @override
  String toString() => 'PhotoUploadLoaded';
}

class PhotoUploadFailure extends PhotoState{
  final String error;
  PhotoUploadFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'PhotoUploadFailure { error: $error }';
}

class PhotoGetInitial extends PhotoState{
  @override
  String toString() => 'PhotoGetInitial';
}

class PhotoGetLoading extends PhotoState{
  @override
  String toString() => 'PhotoGetLoading';
}

class PhotoGetFailure extends PhotoState{
  final String error;
  PhotoGetFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'PhotoGetFailure { error: $error }';
}

class PhotoGetLoaded extends PhotoState{
  final List<DocumentSnapshot> photos;

  PhotoGetLoaded({@required this.photos}): super([photos]);

}