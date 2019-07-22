import 'dart:async';

import 'package:flutter_vayes/data/locator.dart';
import 'package:flutter_vayes/data/photo/photo_repository.dart';
import 'package:flutter_vayes/data/user/user_repository.dart';
import 'package:flutter_vayes/photo_bloc/photo_event.dart';
import 'package:flutter_vayes/photo_bloc/photo_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {

  PhotoRepository photoRepository = new PhotoRepository();
  
  @override
  PhotoState get initialState => PhotoUploadInitial();

  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    if(event is PhotoUploadPressed)
    {
      yield PhotoUploadLoading();

      try {
        final isUploaded = await photoRepository.uploadPhoto(
          file: event.photo,
          fileName: event.photoName
        );
        if(isUploaded)
        {
          yield PhotoUploadInitial();
        }
      } catch (error) {
        yield PhotoUploadFailure(error: error.toString());
      }
    }

  }
}