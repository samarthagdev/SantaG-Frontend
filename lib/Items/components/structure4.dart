import 'dart:convert';
import 'package:AgrawalSeller/Search/component/searchresult.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';

class Structure4 extends StatefulWidget {
  final url;
  Structure4({this.url,});
  @override
  _Structure4State createState() => _Structure4State();
}

class _Structure4State extends State<Structure4> {
  
  Future <dynamic> getstructure4() async{
    
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

  Future<dynamic> futureStructure4;

  @override
  void initState() {
    super.initState();
    futureStructure4 = getstructure4();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: futureStructure4,
        builder: (context, snapshot) {
          if (snapshot.hasData){
          return ListView.builder(

            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context,index){
              var structure4 = snapshot.data;
              
              return Card(
                                  
                                  elevation: 0,
                                  margin: EdgeInsets.only(left: 10,right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure4[3]['url'],querry2: structure4[3]['name'],)));
            },
                                            child: Container(
                                            height: 150,
                                            
                                            width: MediaQuery.of(context).size.width / 2.4,
                                            decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage('https://www.agrawalindustry.com${structure4[3]["img"]}'),fit: BoxFit.cover)
                                        ),  
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          InkWell(
                                            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure4[2]['url'],querry2: structure4[2]['name'],)));
            },
                                            child: Container(
                                              height: 150,
                                              width: MediaQuery.of(context).size.width / 2.4,
                                              decoration: BoxDecoration(
                                              image: DecorationImage(image: NetworkImage('https://www.agrawalindustry.com${structure4[2]["img"]}'),fit: BoxFit.cover)
                                        ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure4[1]['url'],querry2: structure4[1]['name'],)));
            },
                                            child: Container(
                                            height: 150,
                                            
                                            width: MediaQuery.of(context).size.width / 2.4,
                                            decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage('https://www.agrawalindustry.com${structure4[1]["img"]}'),fit: BoxFit.cover)
                                        ),  
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          InkWell(
                                            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: structure4[0]['url'],querry2: structure4[0]['name'],)));
            },
                                            child: Container(
                                              height: 150,
                                              width: MediaQuery.of(context).size.width / 2.4,
                                              decoration: BoxDecoration(
                                              image: DecorationImage(image: NetworkImage('https://www.agrawalindustry.com${structure4[0]["img"]}'),fit: BoxFit.cover)
                                        ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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