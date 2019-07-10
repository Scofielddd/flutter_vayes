import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:meta/meta.dart';


class UserRepository {
  final storage = new FlutterSecureStorage();
  final String uri = "http://10.0.2.2:50567/api";  // you need to be change this port number (not ip adress)

  Future<bool> checkAuthorization() async {
      String readToken =await storage.read(key: "jwt");
      var response = await http.get(Uri.encodeFull(uri+"/values/get/1"),
      headers: {"Content-Type": "application/json",
        "Authorization":"Bearer "+ readToken}
      );
      if(response.statusCode != 200)
      {
        print(response.statusCode);
        return false;
      }
      else
      {
        print(response.statusCode);
        return true;
      }
  }

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    /*Map data = {
      "Username":username,
      "Password":password
    };
    var body = json.encode(data);
    var response = await http.post(Uri.encodeFull(uri+"/account/login"),
      headers: {"Content-Type": "application/json"},
      body: body
      );
    print(response.body);
    if(response.statusCode!=200)
    {
      print(response.statusCode);
      return "error";
    }
    else if(response.statusCode==200)
      return response.body;*/
    return "ksjdıo2j";
  }

  Future<bool> deleteToken() async {
    /// delete from keystore/keychain
    await storage.deleteAll();
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  Future<bool> checkTimerToken() async {
    try {
      String readToken =await storage.read(key: "jwt");
      var response = await http.get(Uri.encodeFull(uri+"/values/get/1"),
      headers: {"Content-Type": "application/json",
        "Authorization":"Bearer "+ readToken}
      );
      if(response.statusCode!=200)
      {
        await storage.deleteAll();
        return false;
      }
      else
        return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future <bool> persistToken(String token) async {
    /// write to keystore/keychain
    await storage.write(key: "jwt",value: token);
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    try {
      String readToken =await storage.read(key: "jwt");
      await Future.delayed(Duration(seconds: 1));
      if(readToken != null && await checkTimerToken()==true) 
        return true;
      else  
      {
        await storage.deleteAll();
        return false;
      }
    } catch (e) {
      print(e);
      await storage.deleteAll();
      return false;
    }
    
  }
}