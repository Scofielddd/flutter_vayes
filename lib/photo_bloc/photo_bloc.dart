import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    if (event is PhotoUploadPressed) {
      yield PhotoUploadLoading();

      try {
        final isUploaded = await photoRepository.uploadPhoto(
            file: event.photo, fileName: event.photoName);
        if (isUploaded) {
          yield PhotoUploadInitial();
        }
      } catch (error) {
        yield PhotoUploadFailure(error: error.toString());
      }
    }

    if (event is PhotosGetPressed) {
      yield PhotoGetInitial();
      yield PhotoGetLoading();

      try {
        List<DocumentSnapshot> photos =
            await photoRepository.getPhotos(userGuid: event.userGuid);
        /*for (var item in photos) {
          print(item.data);
        }*/
        yield PhotoGetLoaded(photos: photos);
      } catch (e) {
        yield PhotoGetFailure(error: e.toString());
      }
    }
  }
}
