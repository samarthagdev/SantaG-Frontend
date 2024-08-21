import 'dart:convert';
import 'package:AgrawalSeller/Search/component/searchresult.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class Structure3 extends StatefulWidget {
  final url;
  
  Structure3({this.url});
  
  @override
  _Structure3State createState() => _Structure3State();
}

class _Structure3State extends State<Structure3> {
  Future <dynamic> getstructure3() async{
    
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

  Future<dynamic> futureStructure3;

  @override
  void initState() {
    super.initState();
    futureStructure3 = getstructure3();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(

      child: FutureBuilder<dynamic>(
        future: futureStructure3,
        builder: (context, snapshot) {
          if (snapshot.hasData){
          return CarouselSlider.builder(
            
            itemCount: snapshot.data.length,
            itemBuilder:(context,index){
              var structure3 = snapshot.data[index];
              return InkWell(
                onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure3['url'],querry2: structure3['name'],)));
            },
                child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                                image: DecorationImage(
                                                  image: NetworkImage('https://www.agrawalindustry.com${structure3["img"]}'),
                                                  fit: BoxFit.cover
                                                  )
                                              ),
                                            ),
              );
            },
            options: CarouselOptions(
                                          height: 400,
                                          autoPlay: true
                                        )
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
