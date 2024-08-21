import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:AgrawalSeller/sidebar/Storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class Myorder extends StatefulWidget {
  @override
  _MyorderState createState() => _MyorderState();
}

class _MyorderState extends State<Myorder> {
  final SecureStorage _storage1 = SecureStorage();
  var number;
  var res;
  Future <dynamic> cart({number}) async{
    
    final response = await http.post(Uri.encodeFull("https://www.agrawalindustry.com/bag/myorder/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
     body:jsonEncode(<String, dynamic> {
       "number":number
     } 
    ));
    if (response.statusCode == 200) {   
    res = json.decode(response.body);
    
    setState(() {  
    });
    return json.decode(response.body);
    
    }
    else {
    throw Exception('Failed to load album');
  }        
  }
Future<dynamic> cartitem;
  @override
  void initState() {
    super.initState();
     
    _storage1.readSecureData('number').then((value){
          number = value;
          
          cartitem = cart(number: number);
          setState(() {
          });});
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
        child: Column(
          children: <Widget>[
            order()
          ],
        ),
      ),
    );  
  }
  order(){
    if (res != null && res.length >=1){
    return Container(
        
        child: FutureBuilder<dynamic>(
                future: cartitem,
                builder: (context, snapshot){
                 
                  
                 if (snapshot.hasData){
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: res.length,
                    itemBuilder: (context, index) {
                    var items = res[index];
                    return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red)
                        ),
                        child: Card(
                          elevation: 5.0,
                          
                          child: Column(
                            children: <Widget>[
                              Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                                    children: <Widget>[
                                      Container(
                                        // decoration: ,
                                        child: Image.network('https://www.agrawalindustry.com${items['cosImage1']}',
                                          width: MediaQuery.of(context).size.width/3,
                                          height: 150,
                                          ),
                                      ),
                                        SizedBox(width: 5,),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context).size.width/2,
                                              child: Text(items['cosBrand'] != null ?items['cosBrand']:'', softWrap: false, maxLines: 1,overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.merienda(
                                                    fontStyle: FontStyle.normal,
                                                    textStyle: TextStyle(
                                                      // color: Colors.orange,
                                      // fontWeight:FontWeight.w600,
                                      fontSize: 30
                                      )
                                      ),),
                                            ),
                                            Container(
                                              
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context).size.width/3,
                                                  child: Text(items['cosName'] != null ?items['cosName']:'', maxLines: 1, overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.rajdhani(
                                                    fontStyle: FontStyle.normal,
                                                    textStyle: TextStyle(
                                      // fontWeight:FontWeight.w600,
                                      fontSize: 17
                                      )
                                      )
                                      ),
                                                ),
                                                Container(
                                              
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context).size.width/3,
                                                  child: Row(
                                                    children: [
                                                     Text('Quantity: ', maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.rajdhani(
                                                        fontStyle: FontStyle.normal,
                                                        textStyle: TextStyle(
                                      fontWeight:FontWeight.w600,
                                      fontSize: 17
                                      )
                                      )
                                      ),
                                                      Text(items['Quantityorder'] != null ?items['Quantityorder'].toString():'', maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.rajdhani(
                                                        fontStyle: FontStyle.normal,
                                                        textStyle: TextStyle(
                                      // fontWeight:FontWeight.w600,
                                      fontSize: 17
                                      )
                                      )
                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context).size.width/3,
                                                  child: Text(items['order'] != null ?items['order'].toString():'', maxLines: 1, overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.rajdhani(
                                                    fontStyle: FontStyle.normal,
                                                    textStyle: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.red
                                                      ))),
                                                      ),
                                            
                                                                      
                                          ],
                                        )
                                        
                                    ],
                                  ),
                                  
                            ],
                          ),
                        ),
                      );},
                    );
                    }
                  
                    else if(snapshot.hasError){
                      return Container(
                        child: Text('Sorry their is some error')
                      );
                    }
                    
                    return CircularProgressIndicator();

                },
                
                
        ),
      );}
      else {
        return Container(
          margin: EdgeInsets.only(top:100),
          alignment: Alignment.bottomCenter,
          child: Text('No Order Yet', textAlign: TextAlign.center, style: TextStyle(
            fontSize: 20,
          ),),
        );
      }
  }
}