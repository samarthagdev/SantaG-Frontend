
import 'dart:convert';
import 'package:AgrawalSeller/Search/component/searchresult.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';

class Structure1 extends StatefulWidget {
  final url;
  
  Structure1({this.url});
  @override
  _Structure1State createState() => _Structure1State();
}

class _Structure1State extends State<Structure1> {
  
  Future <dynamic> getstructure1() async{
    
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

  Future<dynamic> futureStructure1;

  @override
  void initState() {
    super.initState();
    futureStructure1 = getstructure1();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: FutureBuilder<dynamic>(
        future: futureStructure1,
        builder: (context, snapshot){
          
          if (snapshot.hasData){
          
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
            var structure1 = snapshot.data[index];
          
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure1['url'],querry2: structure1['name'],)));
            },
            child: Card(

                                  child: Container(
                                    
                                    height: 300,
                                    decoration: BoxDecoration(
                                      
                                      image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure1["img"]}"),fit: BoxFit.cover)
                                    ),
                                  ) ,
                                ),
          );


            },
            );}
            else if(snapshot.hasError){
              return null;
            }
            
            return CircularProgressIndicator();

        },
        
      ),
    );

  }
}