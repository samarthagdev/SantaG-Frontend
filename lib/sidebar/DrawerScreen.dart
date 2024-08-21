import 'dart:convert';
import 'package:AgrawalSeller/sidebar/Storage.dart';
import 'package:AgrawalSeller/sidebar/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:AgrawalSeller/Bag/myorder.dart';
import 'package:AgrawalSeller/main.dart';
import 'package:AgrawalSeller/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Future <dynamic> account({number}) async{
    
    final response = await http.post(Uri.encodeFull("https://www.agrawalindustry.com/usercorrections/usercorrection"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
     body:jsonEncode(<String, dynamic> {
       "number":number
     } 
    ));
    if (response.statusCode == 200) {

    return json.decode(response.body);
    
    }
    else {
    throw Exception('Failed to load album');
  }        
  }
  void setuser(){
   _storage.readSecureData('number').then((value){
          number = value;
          cartitem = account(number: number);
          setState(() {
          });});
  }
  
  final SecureStorage _storage =SecureStorage();
  Future<dynamic> cartitem;
  var number;
  @override
  void initState() {
    
    super.initState();
    setuser();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: cartitem,
      builder: (context, snapshot){
        if (snapshot.hasData){
      return Container(
        color: Colors.grey[200],
        padding: EdgeInsets.only(top:50,bottom: 70,left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              
              children: [
                CircleAvatar(maxRadius: 50,
                backgroundImage: AssetImage('assets/hi.png'),backgroundColor: Colors.grey[850],),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(snapshot.data['username'],overflow: TextOverflow.clip,style: TextStyle(color: Colors.grey[850],fontWeight: FontWeight.bold,fontSize: 25),)),
                    Text('Active Status',style: TextStyle(color: Colors.grey[850],fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),

            Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (contex)=>Myorder()));
                  },
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.gift,color: Colors.grey,size: 30,),
                      SizedBox(width: 10,),
                      Text('My Order',style: TextStyle(color: Colors.grey[850],fontWeight: FontWeight.bold,fontSize: 20))
                    ],

                  ),
              ),
                ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings(username: snapshot.data['username'],number:number,))).then((_) {
                    setuser();
                  } );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.userAlt,color: Colors.grey,size: 30,),
                      SizedBox(width: 10,),
                      Text('Profile',style: TextStyle(color: Colors.grey[850],fontWeight: FontWeight.bold,fontSize: 20))
                    ],

                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (contex) => Menu()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.buffer,color: Colors.grey,size: 30,),
                      SizedBox(width: 10,),
                      Text('Hotel Menu',style: TextStyle(color: Colors.grey[850],fontWeight: FontWeight.bold,fontSize: 20))
                    ],

                  ),
                ),
              )
              ]
            ),

            Row(
              children: [
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    _storage.deleteallSecureData();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()),(Route<dynamic> route) => false);
  
                  },
                  child: Text('Log out',style:TextStyle(fontSize: 20,color: Colors.grey[850],fontWeight: FontWeight.bold),))


              ],

            )


          ],
        ),
      );}
      else if(snapshot.hasError){
        return Text("${snapshot.error}");
      }
      return CircularProgressIndicator();
      }
      
    );
  }
}