import 'package:AgrawalSeller/sidebar/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:AgrawalSeller/models/Categories_modle.dart';
class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

List<dynamic> menu = [];
List<dynamic> card = [];
List<dynamic> hotel = [];
  Future <dynamic> getmenu() async{
    final response = await http.get(Uri.encodeFull("https://www.agrawalindustry.com/menu/card/"),
    headers: {"Accept":"application/json",});
    if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonresponse = json.decode(response.body);
     for (var x in jsonresponse){
       menu.add(Menucard(x['image'],x['post']));
     }
     
     menu.forEach((element) { 
       hotel.add(element.post);
     });
     hotel = hotel.toSet().toList();
     return jsonresponse;
    }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
          
  }

Future<dynamic> menuitem;


@override
  void initState() {
    super.initState();
    menuitem = getmenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF21BFBD),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: (){
              Navigator.pop(context);
            }),
        ),
      body: SingleChildScrollView(
        child:Container(
              child: FutureBuilder<dynamic>(
                future: menuitem,
                builder: (contex, snapshot){
                  if (snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: hotel.length,
                    itemBuilder: (contex, index){
                      return GestureDetector(
                        onTap: (){

                          menu.forEach((element) {
                            if (element.post == hotel[index]){
                             card.add(element.img);
                            }
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Hotel(item: card,))).then((_) {card = [];});
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 7,top: 10,right: 7),
                          decoration: BoxDecoration(
                            color: Colors.yellow[200],
                            boxShadow: [
                           BoxShadow(
                               color: Color(0xffff7f50),
                               offset: Offset(1.0, 2.0), //(x,y)
                               blurRadius: 10.0,
                             ),
                             ]
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3, right: 5),
                               height: 150,
                               width: MediaQuery.of(context).size.width/3.5,
                                child: Image.asset('assets/menucard.jpg')
                              ),
                              Container(
                                child: Text(hotel[index], textAlign: TextAlign.center,maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.titilliumWeb(
                                                    fontStyle: FontStyle.normal,
                                                    textStyle: TextStyle(
                                        fontSize: 30
                                        ))),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    );}
                    else if (snapshot.hasError){
                      return Container(
                        child: Text('Sorry their is some error')
                      );
                    }
                    return CircularProgressIndicator();
                }
                ),
            )
          
      ),
    );
  }
}