import 'dart:convert';
import 'package:AgrawalSeller/Bag/bag.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:AgrawalSeller/sidebar/Storage.dart';
class Productdetails extends StatefulWidget {
  final detail;
  
  Productdetails({this.detail,});
  
  @override
  _ProductdetailsState createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  Future <dynamic> getCP(q) async{
    final response = await http.get(Uri.encodeFull("https://www.agrawalindustry.com/api/cosmatic/$q/"),
    headers: {"Accept":"application/json",});
    if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonresponse = json.decode(response.body);
    s = jsonresponse;
    addingimg();
    return jsonresponse;
    }else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  }
  
  
Future<dynamic> addtocart( {number,cosToken, cosQuantity}) async {
  final dynamic response = await http.post(
    'https://www.agrawalindustry.com/bag/BagAdding/',
    
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: jsonEncode(<String, dynamic>{
      'number':number,
      'cosToken': cosToken,
      'cosQuantity': cosQuantity,
    }),
    
  );
  if (response.statusCode != 200) {
    
  }
  else if (response.statusCode == 200){
    bottomsheet(context);
    
  }
}
  
  void bottomsheet(contex){
showDialog(
  context: context,
  builder: (ctx) =>AlertDialog(
    title: Text('Item is Added to cart', textAlign: TextAlign.center,),
    backgroundColor: Colors.amber,
    
    
  )
  );}
  
  TextEditingController quantity =TextEditingController() ;
  Future<dynamic> futureCP;
  final SecureStorage _storage1 = SecureStorage();
  // var _count;
  // var _count1;
  var number;
  var response;
  var status = 200;
  int groupValue = 0;
  double q;
  double price;
  var lis = [];
  bool _validate = false;
  int _current;
  var s ;
  List <String>productimg = List<String>();
  
  @override
  void initState() {
    
    super.initState();
    
    futureCP = getCP(widget.detail);
    _storage1.readSecureData('number').then((value){
          setState(() {
          number = value;  
          });});
  }
  
  addingimg(){
   if (s['cosImage1'] != null){
     productimg.add("https://www.agrawalindustry.com${s['cosImage1']}");
   }
   if (s['cosImage2'] != null){
     productimg.add("https://www.agrawalindustry.com${s['cosImage2']}");
   }
   if (s['cosImage3'] != null){
     productimg.add("https://www.agrawalindustry.com${s['cosImage3']}");
   }
   if (s['cosImage4'] != null){
     productimg.add("https://www.agrawalindustry.com${s['cosImage4']}");
   }
   
    setState(() {
    }); 
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
                  future: futureCP,
                  builder: (context, snapshot) {
                    if (s!= null){
        if (s['cosQuantity'] != 0){
          return GestureDetector( 
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            floatingActionButton:FloatingActionButton(
  backgroundColor: const Color(0xff03dac6),
  foregroundColor: Colors.black,
  onPressed: () {
          // Respond to button press
          if (s['measure'] == '2' || s['measure'] == '3'){
            _calculator();
          }
         
          if (status==200){
            
            //  _storage1.deleteallSecureData();
            _storage1.readSecureData('number').then((value){
              setState(() {
              number = value;  
              });
                
              
              
              if (s['measure'] == "1"){
            addtocart(cosToken: s['cosToken'], number: number);
            
          }

          else if (s['measure'] == '2' || s['measure'] == 3){
            if (groupValue == 0){
                var y =double.parse(quantity.text) * 1000.0;
                addtocart(cosToken: s['cosToken'], number: number, cosQuantity:y);
                // Provider.of<CartCount>(context, listen: false).add();
            }
            else if (groupValue == 1){
                addtocart(cosToken: s['cosToken'], number: number, cosQuantity:quantity.text);
                // Provider.of<CartCount>(context, listen: false).add();
            }
            
          }

              }); // storage ending

          }// if ending
  
  },
  child: Icon(Icons.add),
),
            appBar: AppBar(
              actions: [
                Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Badge(
                                    
                                    position: BadgePosition.topEnd(top: 0, end: 0),
                                                    alignment: Alignment.center,   
                                                    badgeColor: Colors.red,
                                                    animationType: BadgeAnimationType.fade,
                                                      badgeContent: null,
                                                      child: IconButton(
                                                        
                                                   icon: Icon(Icons.add_shopping_cart),
                                                   color: Colors.white,
                                                   onPressed: (){
                                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Bag(number: number,)));
                                                   },
                                                  ),
                                                    ),
                                ),
                               
              ],
              backgroundColor: Color(0xFF21BFBD),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), onPressed: ()=>Navigator.pop(context,)),
            ),

            body: SafeArea(
              child: SingleChildScrollView(
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GFCarousel(
                        height: MediaQuery.of(context).size.height/3,
                        items: productimg.map(
           (url) {
           return Container(
             
             margin: EdgeInsets.all(8.0),
             child: ClipRRect(
                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                       url,
                       fit: BoxFit.cover,
                        width: double.infinity
                     ),
                  ),
            );
            },
           ).toList(),
          onPageChanged: (index) {
            setState(() {
                  _current = index;
            });
          },
                        ),
                        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(productimg, (index, url) {
          return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.redAccent : Colors.green,
                  ),
          );
          }),
),
Divider(color: Colors.grey[300],height: 30,thickness: 10,),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(s['cosBrand'], textAlign: TextAlign.start ,style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w400,
                                                fontSize: 30)),),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(s['cosName'], textAlign: TextAlign.start ,style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w100,
                                                fontSize: 20)),),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _price(productprice:s['cosPrice'], dis:s['cosDis']),
                        Divider(color: Colors.grey[300],height: 30,thickness: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Size', textAlign: TextAlign.start ,style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w400,
                                                fontSize: 25)),),
                        ),
                        SizedBox(height: 5,),
                        _ProductSize(),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey[300],height: 30,thickness: 10,),
                        
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Description', textAlign: TextAlign.start ,style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w400,
                                                fontSize: 25)),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                                s['description']==null? 'No Description Available for this product':s['description'],
                                style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w400,
                                                fontSize: 17)),),
                        ),

                    ],
                  ),
                  ),
                  
              ),

          ),
        );
        }








        else{
          return GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            
            appBar: AppBar(
              actions: [
                Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Badge(
                                    
                                    position: BadgePosition.topEnd(top: 0, end: 0),
                                                    alignment: Alignment.center,   
                                                    badgeColor: Colors.red,
                                                    animationType: BadgeAnimationType.fade,
                                                      badgeContent: null,
                                                      child: IconButton(
                                                        
                                                   icon: Icon(Icons.add_shopping_cart),
                                                   color: Colors.white,
                                                   onPressed: (){
                                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Bag(number: number,)));
                                                   },
                                                  ),
                                                    ),
                                ),
                                         ],
              backgroundColor: Color(0xFF21BFBD),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), onPressed: ()=>Navigator.pop(context)),
            ),

            body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GFCarousel(
                        height: MediaQuery.of(context).size.height/3,
                        items: productimg.map(
           (url) {
           return Container(
             
             margin: EdgeInsets.all(8.0),
             child: ClipRRect(
                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                       url,
                       fit: BoxFit.cover,
                        width: double.infinity
                     ),
                  ),
            );
            },
           ).toList(),
          onPageChanged: (index) {
            setState(() {
                  _current = index;
            });
          },
                        ),
                        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(productimg, (index, url) {
          return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.redAccent : Colors.green,
                  ),
          );
          }),
),
Divider(color: Colors.grey[300],height: 30,thickness: 10,),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(s['cosBrand'], textAlign: TextAlign.start ,style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w400,
                                                fontSize: 30)),),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(s['cosName'], textAlign: TextAlign.start ,style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w100,
                                                fontSize: 17)),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Out of Stock', textAlign: TextAlign.start ,style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                color: Colors.red,
                                                fontWeight:FontWeight.w100,
                                                fontSize: 17)),),
                        ),
                        Divider(color: Colors.grey[300],height: 30,thickness: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Size', textAlign: TextAlign.start ,style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w400,
                                                fontSize: 25)),),
                        ),
                        SizedBox(height: 5,),
                        _ProductSize(),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey[300],height: 30,thickness: 10,),
                        
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text('Description', textAlign: TextAlign.start ,style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w400,
                                                fontSize: 25)),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                                s['description']==null? 'No Description Available for this product':s['description'],
                                style: GoogleFonts.playfairDisplay(
                                              textStyle: TextStyle(
                                                fontWeight:FontWeight.w400,
                                                fontSize: 17)),),
                        ),

                    ],
                  ),
                ),
                
              ),

          ),
        );
        }
  }
  else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
  }
  
  );
  }
_price({productprice, dis}){
if (dis == null){
  return Padding(
    padding: EdgeInsets.only(left: 13),
    child: Text("₹ ${productprice.toString()}", style: TextStyle(
      fontSize: 15
    ),));
    
}

else{
  var price1 = productprice ;
   productprice = price1 - price1*dis~/100;
return Padding(
  padding: EdgeInsets.only(left: 13),
  child:   Row(
  
       children: <Widget>[
  
         Text("₹ ${productprice.toString()}"),
  
         SizedBox(width: 5,),
  
         Text("₹ ${price1.toString()}", style: TextStyle(
  
           decoration: TextDecoration.lineThrough
  
         ),),
  
         SizedBox(width: 5,),
  
         Text("$dis% OFF", style: TextStyle(
  
       color: Colors.red
  
     ), )
  
       ],
  
     ),
); 
}
}
_ProductSize(){
  if (s["measure"] == "1"){
     lis = s["measure1"].split('/');
     
     return Container(
       height: 50,
       width: double.infinity,
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         shrinkWrap: true,
         itemCount: lis.length ,
         itemBuilder: (BuildContext context, int index){

         
         return Container(
                      margin: EdgeInsets.only(left: 15),
                      height: 40,
                      width: 80,
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(lis[index],textAlign: TextAlign.center, style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.lightGreen[600],
                        fontSize: 20,
                      ),),
                    );
         
         }),
     );
    
    }

    else if(s["measure"] == "2" || s["measure"] == "3"){
      if (status == 200){
      lis = s["measure1"].split('/');
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: _validate == false?50:60,
            child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  
                    child: TextField(
                      controller: quantity,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
                      decoration: InputDecoration(
                        errorText: _validate ? 'Field Can\'t Be Empty' : null,
                        contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                        hintText: 'Type Quantity',
                        
                        border: InputBorder.none
                      ),
                      
                    ),
                  
                  ),
                ),
              
          ),
          Container(
            alignment: Alignment.topCenter,
            
       height: 100,
       width: double.infinity,
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         shrinkWrap: true,
         itemCount: lis.length ,
         itemBuilder: (BuildContext context, int index){
         
         return  GFCard(
           boxFit: BoxFit.fill,
    content: Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GFRadio(
          size: GFSize.MEDIUM,
          activeBorderColor: GFColors.SUCCESS,
          value: index,
          groupValue: groupValue,
          onChanged: (val) {
            setState(() {
              groupValue = val;
              
            });
          },
          inactiveIcon: null,
          radioColor: GFColors.SUCCESS,
        ),
        SizedBox(width: 10,),
      Text(lis[index], style: TextStyle(
        fontSize: 15,
      ),)
        
      ],
    ));
         }),
     ),
     Divider(color: Colors.grey[300],height: 30,thickness: 4,),
    //  SizedBox(height: 7,),
     RaisedButton(
       elevation: 4.0,
                splashColor: Colors.lightBlue,
                color: Colors.lightBlue,
                child: new Text("Calculate Price",style: new TextStyle(fontSize: 20.0,color: Colors.white),),
                onPressed: (){
                  setState(() {
                  quantity.text.isEmpty ? _validate = true : _validate = false;  
                  });
                  if (quantity.text.isNotEmpty){
                    _calculator();
                  }
                  
                },
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Text(q == null?'Quantity':q.toString(),style: GoogleFonts.playfairDisplay(
                                      textStyle: TextStyle(
                                        fontWeight:FontWeight.w100,
                                        fontSize: 19 ))),
                                        SizedBox(width: 5,),
                Icon(
                  Icons.arrow_forward_ios, size: 20,
                ),
                SizedBox(width: 5,),
                Text(price == null? 'Price':'₹${price.toString()}',style: GoogleFonts.playfairDisplay(
                                      textStyle: TextStyle(
                                        fontWeight:FontWeight.w100,
                                        fontSize: 19 )))  
                ],
              )
                       
        ],
      );}

      else if (status ==400){
        return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(response, style: TextStyle(
              color: Colors.red
            ),),
          ),
          Container(
            width: double.infinity,
            height: _validate == false?50:60,
            child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  
                    child: TextField(
                      
                      controller: quantity,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
                      decoration: InputDecoration(
                        errorText: _validate ? 'Field Can\'t Be Empty' : null,
                        contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                        hintText: 'Type Quantity',
                        
                        border: InputBorder.none
                      ),
                      
                    ),
                  
                  ),
                ),
              
          ),
          Container(
            alignment: Alignment.topCenter,
            
       height: 100,
       width: double.infinity,
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         shrinkWrap: true,
         itemCount: lis.length ,
         itemBuilder: (BuildContext context, int index){
         
         return  GFCard(
           boxFit: BoxFit.fill,
    content: Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GFRadio(
          size: GFSize.MEDIUM,
          activeBorderColor: GFColors.SUCCESS,
          value: index,
          groupValue: groupValue,
          onChanged: (val) {
            setState(() {
              groupValue = val;
              
            });
          },
          inactiveIcon: null,
          radioColor: GFColors.SUCCESS,
        ),
        SizedBox(width: 10,),
      Text(lis[index], style: TextStyle(
        fontSize: 15,
      ),)
        
      ],
    ));
         }),
     ),
     Divider(color: Colors.grey[300],height: 30,thickness: 4,),
    //  SizedBox(height: 7,),
     RaisedButton(
       elevation: 4.0,
                splashColor: Colors.lightBlue,
                color: Colors.lightBlue,
                child: new Text("Calculate Price",style: new TextStyle(fontSize: 20.0,color: Colors.white),),
                onPressed: (){
                  setState(() {
                  quantity.text.isEmpty ? _validate = true : _validate = false;  
                  });
                  if (quantity.text.isNotEmpty){
                    _calculator();
                  }
                  
                },
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Text(q == null?'Quantity':q.toString(),style: GoogleFonts.playfairDisplay(
                                      textStyle: TextStyle(
                                        fontWeight:FontWeight.w100,
                                        fontSize: 19 ))),
                                        SizedBox(width: 5,),
                Icon(
                  Icons.arrow_forward_ios, size: 20,
                ),
                SizedBox(width: 5,),
                Text(price == null? 'Price':'₹${price.toString()}',style: GoogleFonts.playfairDisplay(
                                      textStyle: TextStyle(
                                        fontWeight:FontWeight.w100,
                                        fontSize: 19 )))  
                ],
              )
                       
        ],
      );
      }
    }
}

_calculator(){
    
    if (groupValue == 0){
      try{
      var one = double.parse(quantity.text);
      one  = one * 1000;
      var two = double.parse(s['maxlimit']);
      var three = s['cosQuantity'].toDouble();
      
      
      if (one<two && one<three ){
        
        setState(() {
        status = 200;
        q = one; 
        price = q * s['cosPrice'];
          
        });
      }
      else{
        setState(() {
        response = 'Max Quantity you can order ${two.toString()} and Quantity Remaining ${three.toString()}';
        status = 400;
      });

      }
    }
    on Exception{
      setState(() {
        response = 'You Entered Wrong Quantity';
        status = 400;
      });
    }
    }
    else if (groupValue == 1){
     try{
      var one = int.parse(quantity.text);
      var one1 = double.parse(quantity.text);
      var two = double.parse(s['maxlimit']);
      var three = s['cosQuantity'].toDouble();
      if (one1<two && one1<three){
        setState(() {
        status = 200;
        q = one1;
        price = q * s['cosPrice']  ;  
        });
        
      }
      else{
         var three1 = three.toString();
         var two1 = two.toString();
        setState(() {
        response = 'Max Quantity you can order $two1 and Quantity Remaining $three1';
        status = 400;
      });
      }
    }
    on Exception{
      setState(() {
        response = 'You Entered Wrong Quantity';
        status = 400;
      });
    } 

    }
    
  }
  
}