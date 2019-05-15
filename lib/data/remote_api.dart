import 'dart:convert';
import 'package:flutter_vayes/models/photo.dart';
import 'package:http/http.dart' as http;

Photo photo;

Future<Photo> getPhoto(int photoId) async {
  var response = await http.get("https://jsonplaceholder.typicode.com/photos/"+photoId.toString());
  if(response.statusCode == 200){
    return Photo.fromJson(json.decode(response.body));
  }else{
    throw Exception("Error ${response.statusCode}");
  }
}
