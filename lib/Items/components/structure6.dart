import 'dart:convert';

import 'package:AgrawalSeller/Search/component/searchresult.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


import 'package:flutter/material.dart';

class Structure6 extends StatefulWidget {
  final url;
  Structure6({this.url});
  @override
  _Structure6State createState() => _Structure6State();
}

class _Structure6State extends State<Structure6> {

  Future <dynamic> getstructure6() async{
    
    final response = await http.get(Uri.encodeFull("https://www.agrawalindustry.com/${widget.url}"),
    headers: {"Accept":"application/json",});
    if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonresponse = json.decode(response.body);
    

    return jsonresponse;
    }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
          
  }

  Future<dynamic> futureStructure6;

  @override
  void initState() {
    super.initState();
    futureStructure6 = getstructure6();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
          child: FutureBuilder<dynamic>(
            future: futureStructure6,
            builder:(contex, snapshot){
              if (snapshot.hasData){
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder:(context, index){
                  var structure6 =snapshot.data[index];
                   
                  return InkWell(
                    onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure6['url'],querry2: structure6['name'],)));
            },
                    child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:  NetworkImage('https://www.agrawalindustry.com${structure6['img']}',),
              ),
            ),
                  );
                }
                );}
                else if(snapshot.hasError){
                  return null;
                }
                return CircularProgressIndicator();
            }
            ),
        );
  }
}