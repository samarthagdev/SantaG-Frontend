import 'package:AgrawalSeller/Search/component/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';


class Structure8 extends StatefulWidget {
  final url;
  
  Structure8({this.url});
  
  @override
  _Structure8State createState() => _Structure8State();
}

class _Structure8State extends State<Structure8> {
  Future <dynamic> getstructure8() async{
    
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

  Future<dynamic> futureStructure8;

  @override
  void initState() {
    super.initState();
    futureStructure8 = getstructure8();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey[200],
      child: FutureBuilder<dynamic>(
  future: futureStructure8, 
  builder: (context, snapshot) {
      
      if (snapshot.hasData) {
        return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index){           
          var apidata = snapshot.data[index];
          var cosPrice = apidata['cosPrice'].toString();
          return GestureDetector(
            onTap: (){
              
              Navigator.push(context, MaterialPageRoute(builder: (contex)=> Productdetails(detail: apidata['cosToken'],)));
            
            },
            child: Card(
              elevation: 5.0,
              child: AspectRatio(
                aspectRatio: 1/1.3,
                child: Container(
                  
                        //margin: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[500]),
                          // borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 30,),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                             
                              child: Image.network(
                                '${apidata['cosImage1']}',
                                height: 141,
                                width: double.infinity,
                                ),
                            ),                      
                            Container(
                                    child: Text(apidata["cosBrand"], softWrap: false,overflow: TextOverflow.fade,maxLines: 1,style: GoogleFonts.playfairDisplay(textStyle:TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold
                                    ),)),
                                  ),
                                  Container(child: Text(apidata["cosName"],softWrap: false,overflow: TextOverflow.ellipsis,maxLines: 1)),
                            SizedBox(height: 10,),
                            Container(
                              width: 90,
                              child: apidata['cosDis']==null?Text('₹$cosPrice', textAlign:TextAlign.center,style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                              ),): priceDis(cosPrice:apidata['cosPrice'],cosDis:apidata['cosDis'])
                            )
                          ],
                        ),
                      
                ),
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

  Widget priceDis({cosPrice, cosDis}){
  var dis = cosPrice - (cosPrice*cosDis)~/100;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text('₹$dis', textAlign:TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      SizedBox(width: 5,),
      Expanded(
        child: Text('₹$cosPrice', textAlign:TextAlign.center, overflow: TextOverflow.ellipsis, softWrap: true, maxLines: 1,
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red,fontSize: 15,decoration: TextDecoration.lineThrough )),
      ),

    ],
  );
}

}