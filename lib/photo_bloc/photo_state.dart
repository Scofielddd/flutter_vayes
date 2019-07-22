import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PhotoState extends Equatable {
  PhotoState([List props = const []]) : super(props);
}

class PhotoUploadInitial extends PhotoState{
  @override
  String toString() => 'PhotoUploadInitial';
}

class PhotoUploadLoading extends PhotoState{
  @override
  String toString() => 'PhotoUploadLoading';
}

class PhotoUploadFailure extends PhotoState{
  final String error;
  PhotoUploadFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'PhotoUploadFailure { error: $error }';
}

