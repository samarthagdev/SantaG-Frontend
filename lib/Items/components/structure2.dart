import 'package:AgrawalSeller/Search/component/searchresult.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Structure2 extends StatefulWidget {
  final url;
  Structure2({this.url});
  @override
  _Structure2State createState() => _Structure2State();
}

class _Structure2State extends State<Structure2> {
  Future <dynamic> getstructure2() async{
    
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

  Future<dynamic> futureStructure2;

  @override
  void initState() {
    super.initState();
    futureStructure2 = getstructure2();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: FutureBuilder<dynamic>(
        future: futureStructure2,
        builder: (context, snapshot){
          
          if (snapshot.hasData){
          
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
          var structure2 = snapshot.data[index];
          
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure2['url'],querry2: structure2['name'],)));
            },
            child: Card(

                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure2["img"]}"),fit: BoxFit.cover)
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