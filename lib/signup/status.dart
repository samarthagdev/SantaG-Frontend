import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final status;
  final code;
  final pass;
  Status({this.status, this.code, this.pass});
  
  
  @override
  Widget build(BuildContext context) {
  if (code == 400){  
    return Container(
      child: Text(status, style: TextStyle(
        color: Colors.red
      ),),
    );}

    else if(pass){
      return Container(
      child: Text("Your Password is not matching", style: TextStyle(
        color: Colors.red
      ),),
    );
    }
    else{
      return Container(
        child: Text('Fill The Following Fields'),
      );
    }
  }
}