import 'package:AgrawalSeller/Search/component/searchresult.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Structure7 extends StatefulWidget {
  final url;
  Structure7({this.url});
  @override
  _Structure7State createState() => _Structure7State();
}

class _Structure7State extends State<Structure7> {
  Future <dynamic> getstructure7() async{
    
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

  Future<dynamic> futureStructure7;

  @override
  void initState() {
    super.initState();
    futureStructure7 = getstructure7();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey[200],
      child: FutureBuilder<dynamic>(
  future: futureStructure7, 
  builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          //physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index){           
          var apidata1 = snapshot.data[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>SearchResult(querry1: apidata1['url'],querry2: apidata1['name'],)));
            },
            child: Card(
              elevation: 5.0,
              child: Container(
                child: Container(
                      //margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[500]),
                        //borderRadius: BorderRadius.circular(25),
                        color: Colors.white
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Container(
                           width: 160,
                            child: Image.network(
                              'https://www.agrawalindustry.com${apidata1['img']}',
                              fit: BoxFit.fill,
                              ),
                          ),                      
                          
                        
                    )
                  
              ),
            ),
          );
        });
      
      
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }

      // By default, show a loading spinner.
      return CircularProgressIndicator();
  },
),
    );
  }
}