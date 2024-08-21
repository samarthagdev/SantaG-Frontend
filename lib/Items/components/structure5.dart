import 'dart:convert';
import 'package:AgrawalSeller/Search/component/searchresult.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';

class Structure5 extends StatefulWidget {
  final url;
  Structure5({this.url});
  @override
  _Structure5State createState() => _Structure5State();
}

class _Structure5State extends State<Structure5> {
  Future <dynamic> getstructure5() async{
    
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

  Future<dynamic> futureStructure5;

  @override
  void initState() {
    super.initState();
    futureStructure5 = getstructure5();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: futureStructure5,
        builder:(context, snapshot) {
          if (snapshot.hasData){
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder:(contex, index){
              var structure5 = snapshot.data;
              return Card(
                                  child: Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure5[0]['url'],querry2: structure5[0]['name'],)));
            },
                                        child: Container(
                                        height: 200,
                                        
                                        width: MediaQuery.of(context).size.width / 2.2,
                                        decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage('https://www.agrawalindustry.com${structure5[0]["img"]}'),fit: BoxFit.cover)
                                    ),  
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      InkWell(
                                        onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure5[1]['url'],querry2: structure5[1]['name'],)));
            },
                                        child: Container(
                                          height: 200,
                                          width: MediaQuery.of(context).size.width / 2.2,
                                          decoration: BoxDecoration(
                                          image: DecorationImage(image: NetworkImage('https://www.agrawalindustry.com${structure5[1]["img"]}'),fit: BoxFit.cover)
                                    ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
              
            });}
            else if (snapshot.hasError){
              return null;
            }
            return CircularProgressIndicator();
        }, 
        ),
    );
  }
}