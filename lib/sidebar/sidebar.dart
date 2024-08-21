
import 'package:AgrawalSeller/sidebar/Storage.dart';
import 'package:flutter/material.dart';
import 'package:AgrawalSeller/userdash.dart';
import 'DrawerScreen.dart';

import 'dart:async';
class HomeScreen extends StatefulWidget {
  final ui;
  final number;
  final page;
  HomeScreen({this.ui, this.number, this.page});
  @override
  HhomeStateScreen createState() => HhomeStateScreen();
}

class HhomeStateScreen extends State<HomeScreen> {
final SecureStorage _storage = SecureStorage();

@override
  void initState() {
    super.initState();
    _settext();
  }
Future<void> _settext() async{

  if (widget.page == 'login'|| widget.page == 'otp'){
    _storage.writeSecureData('token', widget.ui);
    _storage.writeSecureData('number', widget.number);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          UserDashPage()
      
        ],
      ),
    );
  }
}