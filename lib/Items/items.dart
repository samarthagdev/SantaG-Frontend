import 'package:AgrawalSeller/Items/components/structure1.dart';
import 'package:AgrawalSeller/Items/components/structure2.dart';
import 'package:AgrawalSeller/Items/components/structure3.dart';
import 'package:AgrawalSeller/Items/components/structure4.dart';
import 'package:AgrawalSeller/Items/components/structure5.dart';
import 'package:AgrawalSeller/Items/components/structure6.dart';
import 'package:AgrawalSeller/Items/components/structure7.dart';
import 'package:AgrawalSeller/Items/components/structure8.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
class DiffrentItems extends StatefulWidget {
  @override
  _DiffrentItemsState createState() => _DiffrentItemsState();
}

class _DiffrentItemsState extends State<DiffrentItems> {
  
  
  Future <dynamic> getitems() async{
    
    final response = await http.get(Uri.encodeFull("https://www.agrawalindustry.com/das/userdaspage/"),
    headers: {"Accept":"application/json",
    });
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

  Future<dynamic> futureItems;
  @override
  void initState() {
    super.initState();
    
    futureItems = getitems();
  }

  @override
  Widget build(BuildContext context) {
  
    
    return FutureBuilder<dynamic>(
        
         future: futureItems, 
         builder: (context, snapshot){
           if (snapshot.hasData) {
             return ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemCount: snapshot.data.length,
                 itemBuilder: (context, index) {
                   var structure = snapshot.data[index];
                   

                   if (structure["identity"] == '2' && structure["switch"] == true) {
                     return Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           SizedBox(height: 25,),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 10),
                             height: 50,
                             decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure["itemname"]}"),fit: BoxFit.fitWidth)
                             ),
                            ),
                           SizedBox(height: 10,),
                           Structure1(url: structure["url"],),
                           Divider(
                             thickness: 15,
                             color: Colors.grey[300],
                           )
                         ],
                       );     
                     }
                   else if(structure['identity'] == '3' && structure['switch'] == true){
                     return Column(
                         children: <Widget>[
                           SizedBox(height: 25,),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 10),
                             height: 50,
                             decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure["itemname"]}"),fit: BoxFit.fitWidth)
                             ),
                            ),
                           SizedBox(height: 10,),
                           Structure2(url: structure["url"],),
                           Divider(
                             thickness: 15,
                             color: Colors.grey[300],
                           )
                         ],
                       );
                   }
                   else if(structure['identity'] == '4' && structure['switch'] == true){
                     return Column(
                         children: <Widget>[
                           SizedBox(height: 25,),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 10),
                             height: 50,
                             decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure["itemname"]}"),fit: BoxFit.fitWidth)
                             ),
                            ),
                           SizedBox(height: 10,),
                           Structure3(url: structure["url"],),
                           Divider(
                             thickness: 15,
                             color: Colors.grey[300],
                           )
                         ],
                       );
                   }
                   else if(structure['identity'] == '5' && structure['switch'] == true){
                     return Column(
                       children: <Widget>[
                         SizedBox(height: 25,),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 10),
                             height: 50,
                             decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure["itemname"]}"),fit: BoxFit.fitWidth)
                             ),
                            ),
                         SizedBox(height: 10,),
                         Structure4(url: structure["url"],),
                         Divider(
                           thickness: 15,
                           color: Colors.grey[300],
                         )
                       ],
                     );
                   }
                   else if(structure['identity'] == '6' && structure['switch'] == true){
                     return Column(
                       children: <Widget>[
                         SizedBox(height: 25,),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 10),
                             height: 50,
                             decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure["itemname"]}"),fit: BoxFit.fitWidth)
                             ),
                            ),
                         SizedBox(height: 10,),
                         Structure5(url: structure["url"],),
                         Divider(
                           thickness: 15,
                           color: Colors.grey[300],
                         )
                       ],
                     );
                   }
                   else if(structure['identity'] == '7' && structure['switch'] == true){
                     return Column(
                       children: <Widget>[
                         SizedBox(height: 25,),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 10),
                             height: 50,
                             decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure["itemname"]}"),fit: BoxFit.fitWidth)
                             ),
                            ),
                         SizedBox(height: 10,),
                         Structure6(url: structure["url"],),
                         Divider(
                           thickness: 15,
                           color: Colors.grey[300],
                         )
                       ],
                     );
                   }
                   else if(structure['identity'] == '8' && structure['switch'] == true){
                     return Column(
                       children: <Widget>[
                         SizedBox(height: 25,),
                        Container(
                          margin: EdgeInsets.only(left: 20,right: 10),
                             height: 50,
                             decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure["itemname"]}"),fit: BoxFit.fitWidth)
                             ),
                            ),
                         SizedBox(height: 10,),
                         Structure7(url: structure["url"],),
                         Divider(
                           thickness: 15,
                           color: Colors.grey[300],
                         )
                       ],
                     );
                   }
                   else if(structure['identity'] == '9' && structure['switch'] == true){
                     return Column(
                       children: <Widget>[
                         SizedBox(height: 25,),
                         Container(
                           margin: EdgeInsets.only(left: 20,right: 10),
                             height: 50,
                             decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("https://www.agrawalindustry.com${structure["itemname"]}"),fit: BoxFit.fitWidth)
                             ),
                            ),
                         SizedBox(height: 10,),
                         Structure8(url: structure["url"],),
                         Divider(
                           thickness: 15,
                           color: Colors.grey[300],
                         )
                       ],
                     );
                   }
                   else{
                     return null;
                   }
                 },
                 );
             
           }
           else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }

      // By default, show a loading spinner.
      return CircularProgressIndicator();
         });
    
  }
}