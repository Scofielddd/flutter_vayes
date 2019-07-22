import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotoRepository {
  Future<bool> uploadPhoto({
    @required String file,
    @required String fileName,
  }) async {
    try {
      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child(fileName);

      final StorageUploadTask uploadTask = storageRef.putFile(
        File(file),
      );
      print(uploadTask.isSuccessful);
    } catch (e) {
      print("Error on put photo  : "+e);
      return false;
    }
  }
}
