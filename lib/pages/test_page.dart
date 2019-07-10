import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class TestPage extends StatefulWidget {
  static String tag = "test-page"; 
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  Future<String> getData() async {
    //we have to wait to get the data so we use 'await'
    http.Response response = await http.get(
      //Uri.encodeFull removes all the dashes or extra characters present in our Uri
      Uri.encodeFull("http://10.0.2.2:50567/api/values/get"),
      headers: {
        //if your api require key then pass your key here as well e.g "key": "my-long-key"
       "Accept": "application/json",
       "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiIxIiwicm9sZSI6IkFkbWluIiwibmJmIjoxNTYyMzA4MDQ0LCJleHAiOjE1NjIzMDg2NDQsImlhdCI6MTU2MjMwODA0NCwiaXNzIjoid3d3LnZheWVzLmNvbS50ciIsImF1ZCI6Ind3dy52YXllcy5jb20udHIifQ.Rew-fXnMN4O9iaMX6MQaIn4OBWXAWAQt2msCTKfO6Tc"
      }
    );

    print(response.body);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Stateful Widget!"), backgroundColor: Colors.deepOrange),
      body: new Center(
        child: new RaisedButton(
              child: new Text("Get data!", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
              onPressed: getData
        )
      )
    );
  }
}