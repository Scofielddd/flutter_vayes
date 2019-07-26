import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class PhotoRepository {
  Future<bool> uploadPhoto({
    @required String file,
    @required String fileName,
  }) async {
    try {
      List<int> imageBytes = File(file).readAsBytesSync();
      //print(imageBytes);
      String base64Image = base64Encode(imageBytes);
      Firestore.instance.collection('Photos').document().setData({
        'base64': base64Image,
        'date': DateTime.now().toIso8601String(),
        'user_id': 1
      });

      return true;
    } catch (e) {
      print("Error on put photo  : " + e);
      return false;
    }
  }

  Future<List<DocumentSnapshot>> getPhotos({
    @required String userGuid,
  }) async {
    try {
      List<DocumentSnapshot> _photos = [];
      Query q = Firestore.instance
          .collection("Photos")
          .where('user_id', isEqualTo: 1);
      QuerySnapshot querySnapshot = await q.getDocuments();
      _photos = querySnapshot.documents;
      return _photos;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
