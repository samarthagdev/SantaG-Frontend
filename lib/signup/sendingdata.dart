import 'dart:convert';

import 'package:AgrawalSeller/signup/signup.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Senddata extends StatefulWidget {
  final  username;
  final  password;
  final  number;
  Senddata({this.username, this.number, this.password});
  @override
  _SenddataState createState() => _SenddataState();
}

class _SenddataState extends State<Senddata> {
  Future<dynamic> createAlbum(username, number, password) async {
  final dynamic response = await http.post(
    'https://www.agrawalindustry.com/broadcast/verification',
    
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<String, String>{
      'userName':widget.username,
      'number':widget.number,
      'password': widget.password,
    }),
    
  );
  if (response.statusCode != 200) {
    return SignupPage(status: jsonDecode(response.body));
  }
}

 

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}