import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

class Bag extends StatefulWidget {
  final number;
  
  Bag({this.number});
  @override
  _BagState createState() => _BagState();
}

class _BagState extends State<Bag> {
bool _validate = false;
var details = new Map();
var details1 = new Map(); 
var details2  =new Map();
var total = 0.0 ;
var saving = new Map();
var menu = '1';
var p1;
var s1;
var res;
var addr;
TextEditingController address = TextEditingController();
TextEditingController additional = TextEditingController();
void clearText() {
    additional.clear();
  }
Future <dynamic> order(number) async{
    
    final response = await http.post(Uri.encodeFull("https://www.agrawalindustry.com/addr/address/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',},
    
    body: jsonEncode(<String, dynamic>{
      "number":number,
    }));
    if (response.statusCode == 200) {
    var jsonresponse = json.decode(response.body);
    address = TextEditingController(text:jsonresponse['address']);
    setState(() {
      
    });
    }      
  }

Future <dynamic> removeitems({cosToken,number}) async{
    
    final response = await http.post(Uri.encodeFull("https://www.agrawalindustry.com/bag/removeitems/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
    body: jsonEncode(<String, dynamic>{
      "cosToken":cosToken,
      "number":number,
    }),
    );
    if (response.statusCode == 200) {
    }
    else {

    throw Exception('Sorry there is some error');
  }
          
  }

Future <dynamic> getspecificitem(s) async{
    
    final response = await http.get(Uri.encodeFull("https://www.agrawalindustry.com/api/cosmatic/$s/"),
    headers: {"Accept":"application/json"}
    
    
    );
    if (response.statusCode == 200) {

    var jsonresponse = json.decode(response.body);
    // setState(() {
    // s = true;
    // res = jsonresponse;  
    // });
    
    
    }
    else {

    return false;
  }
          
  }

addmeasure1(jsonresponse){
  res = jsonresponse;
for (var f in jsonresponse){
  if (f['measure'] == '1'){
   details[f['cosToken']] = '1';
   details1[f['cosToken']] =f['cosPrice'];
   if (f['cosDis'] != null){
      saving[f['cosToken']] = f['cosDis'];
   }
   
  
  }
  else{
if (f['cosQuantity']>f['Quantityorder']){
    details2[f['cosToken']] = f['cosPrice']*f['Quantityorder'];
}    

  } 
}

setState(() {
  
});


}

remove(index, cosToken){
  details.remove(cosToken);
  details1.remove(cosToken);
  details2.remove(cosToken);
  saving.remove(cosToken);
  res.removeAt(index);
  setState(() {
  }); 
}
void bottomsheet(contex){
showDialog(
  context: context,
  builder: (ctx) =>AlertDialog(
    title: Text('Order Successful', textAlign: TextAlign.center,),
    backgroundColor: Colors.amber,
    content: Image.asset('assets/ordersucces.jpg'),
    
    
  )
  );}
Future <dynamic> cart({address, items, number,additional}) async{
    
    final response = await http.post(Uri.encodeFull("https://www.agrawalindustry.com/bag/addtocart/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
    body: jsonEncode(<String, dynamic>{
      "items":items,
      "address":address,
      "number":number,
      "additional":additional,
    }),
    
    );
    if (response.statusCode == 200) { 
    // Provider.of<CartCount>(context).removeAll();  
    details.clear();
    details1.clear();
    details2.clear();
    saving.clear();
    res.clear();
    clearText();
    setState(() {  
    });
    bottomsheet(context);
    }
    else {
    throw Exception('Failed to load album');
  }        
  }

Future <dynamic> bagitems({number}) async{
    
    final response = await http.post(Uri.encodeFull("https://www.agrawalindustry.com/bag/itemsBag/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
    
    body: jsonEncode(<String, dynamic>{
      "number":number,
    }),
    
    );
    if (response.statusCode == 200) {

    var jsonresponse = json.decode(response.body);
    
    addmeasure1(jsonresponse);
    return jsonresponse;
    
    }
    else {

    throw Exception('Failed to load album');
  }
          
  }
  var number;
  Future<dynamic> bag;
  
  @override
  void initState() {
    // total  =0.0;
    super.initState();
    number = widget.number;
    bag = bagitems(number:number);
    order(number);  
    setState(() {
      
    });
  }


addtocart(){
  var f = 0;
  while ( f  <res.length){
    if (res[f]['measure']=="1"){
      res[f]['Quantityorder'] = details[res[f]['cosToken']];
    }
    f++;
  }
cart(address: address.text,items: res, number: number, additional:additional.text);
}

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 70,
            padding: EdgeInsets.only(left: 15, right: 15, top:7, bottom: 5),
            child: RaisedButton(
              highlightColor: Colors.tealAccent,
              // splashColor: Colors.pink,
              color: Color(0xffFF1744),
              // focusColor: Colors.pink,
              textColor: Colors.white,
              onPressed: (){
                setState(() {
                    address.text.isEmpty ? _validate = true : _validate = false;  
                    });
                if (address.text.isNotEmpty){
                  addtocart();
                }
              },
              child: Text('PLACE ORDER', style: TextStyle(
                color:Colors.white,
                fontSize: 20,

              ),),
              ),
          ),
        ),
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
                
                Container(
                  child:Text('Delivery Address', textAlign: TextAlign.center,maxLines: 1, overflow: TextOverflow.ellipsis,style: GoogleFonts.merienda(
                                                  fontStyle: FontStyle.normal,
                                                  textStyle: TextStyle(
                                      fontSize: 30
                                      ))),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                  child: TextFormField(
                    // initialValue: addr != null? addr :null,
                    // keyboardType: TextInputType.multiline,
                    maxLines: null,
                     maxLength: 150,
                    controller: address,
                    decoration: InputDecoration(
                      errorText: _validate ? 'Field Can\'t Be Empty' : null,
                      hintText: "Address(House No, Colony,Area, landmark)*",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedBorder: OutlineInputBorder(

                        borderSide: BorderSide(color: Colors.greenAccent),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      )
                    ),
                  ),
                ),
                Divider(color: Colors.grey[300],height: 10,thickness: 10,),
            
                Container(
        
        child: FutureBuilder<dynamic>(
                future: bag,
                builder: (context, snapshot){
                  
                  if (res != null){
                  
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: res.length,
                    itemBuilder: (context, index) {
                    var items = res[index];
                    return  GestureDetector(
                      onTap: (){
                        getspecificitem(items['cosToken']);
                      
                      },
                      child: Container(
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
                                              
                                            
                                            quantitydrop(cosToken: items['cosToken'],quantityavailable: items['cosQuantity'], quantityorder: items['Quantityorder'], measure: items['measure']),
                                            price(cosToken: items['cosToken'],price: items['cosPrice'], dis: items['cosDis'], measure: items['measure'],quantityorder: items['Quantityorder'],),
                                            Divider(color: Colors.grey[300],height: 30,thickness: 10,),
                                                                      
                                          ],
                                        )
                                        
                                    ],
                                  ),
                                  Divider(color: Colors.grey[300],height: 30,thickness: 1,),
                                  InkWell(
                                      onTap: (){

                                        remove(index, items['cosToken']);
                                        removeitems(cosToken: items['cosToken'], number: number);
                                      },
                                  child: Container(
                                    
                                    decoration: BoxDecoration(
                                    
                                      
                                    ),
                                    padding: EdgeInsets.only(bottom: 5),
                                    
                                      child: Text('REMOVE', textAlign: TextAlign.center,style: GoogleFonts.abrilFatface(
                                                
                                                textStyle: TextStyle(
                                                  color: Colors.red[500],
                                      // fontWeight:FontWeight.w600,
                                      fontSize: 20
                                      )
                                      ),)
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    );     
                  


                    },
                    );
                    }
                    // else if (!snapshot.hasData){
                      
                    // }
                    else if(snapshot.hasError){
                      return Container(
                        child: Text('Sorry their is some error')
                      );
                    }
                    
                    return CircularProgressIndicator();

                },
                
        ),
      ),
Divider(color: Colors.grey[300],height: 30,thickness: 20,),
      Container(
                      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                      child: TextFormField(
                        controller: additional,
                        // initialValue: addr != null? addr :null,
                        // keyboardType: TextInputType.multiline,
                        // minLines: 2,
                        // maxLines: 5,
                        //  maxLength: 150,
                        // controller: name,
                        decoration: InputDecoration(
                          hintMaxLines: 5,
                          hintText: "You can Write here if you want something Additional. Price Will be calculated as per your things",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)
                          ),
                          focusedBorder: OutlineInputBorder(

                            borderSide: BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          )
                        ),
                      ),
                    ),
      Divider(color: Colors.grey[300],height: 30,thickness: 20,),
      pricedetail(),
      Container(
                  color: Colors.red[300],
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left:7,bottom:7,right:7),
                    child: Text("Delivery Time Will be from 12.00 A.M to 10 P.M .Your order will be delivery within next 50 min of your order",
                    textAlign: TextAlign.center,maxLines: 5, overflow: TextOverflow.ellipsis,style: GoogleFonts.merienda(
                                                    fontStyle: FontStyle.normal,
                                                    textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                        ))),
                  ),
                ),
              ],
            ),
          ),

        ),
    );
    
  }
pricedetail(){
  total = 0.0;
  var sav = 0.0;
  var lis  = details1.values.toList();
  var lis1  = details.values.toList();
  var lis2  = details2.values.toList();
  var lis3  = saving.keys.toList();
  var e =0;
  while(e < lis.length){
    total = total + lis[e]*double.parse(lis1[e]);
    e++;
  }
  var r =0;
  while(r < lis2.length){
    total = total + lis2[r];
    r++;
  }
  var w = 0;
  while(w < lis3.length){
    sav = sav +  details1[lis3[w]] * double.parse(details[lis3[w]]) * saving[lis3[w]]~/100;
    w++;
  }
var net = total - sav;


 
return Container(
  child: Column(
    children: <Widget>[
      Text('PRICE DETAILS', style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),),
      Divider(color: Colors.grey[300],height: 30,thickness: 1,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text('Total MRP',style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600
      ),),
          ),
          Container(
            padding: EdgeInsets.only(right: 8),
            child: Text("₹ ${total.toString()}",style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300
      ),),
          )
        ],
      ),
      SizedBox(height: 15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text('Total Saving',style: TextStyle(
        fontSize: 20,
        color: Colors.red[300],
        fontWeight: FontWeight.w600
      ),),
          ),
          Container(
            padding: EdgeInsets.only(right:8),
            child: Text("₹ ${sav.toString()}",style: TextStyle(
        fontSize: 20,
        color: Colors.red[300],
        fontWeight: FontWeight.w300
      )),
          )
        ],
      ),
      Divider(color: Colors.grey[300],height: 30,thickness: 1,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text('Total Amount',style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold
      ),),
          ),
          Container(
            padding:EdgeInsets.only(right: 8),
            child: Text("₹ ${net.toString()}",style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w300
      ),),
          )
        ],
      ),
      SizedBox(height: 15,),
      Divider(color: Colors.grey[300],height: 30,thickness: 15,),
    ],
  ),
);
}

quantitydrop({quantityavailable,quantityorder, measure,cosToken}){

if (measure == "1"){
    if(quantityavailable>=10){
      
    return  DropdownButton<String>(
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
    value: details[cosToken] !=null ?details[cosToken]:menu,
    items: <String>["1","2","3","4","5","6","7","8","9","10",].map((String value) {
    return new DropdownMenuItem<String>(
      value:value,
      child: new Text(value,),
    );
  }).toList(),

  onChanged: (value) {
    setState(() {
          details[cosToken] = value;
          
        });
  },
);
 }
 else if(quantityavailable == 9){
   
    return  DropdownButton<String>(
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
    value: details[cosToken] !=null ?details[cosToken]:menu,
    items: <String>["1","2","3","4","5","6","7","8","9",].map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),

  onChanged: (value) {
    setState(() { 
      details[cosToken] = value;
          
        });
  },
);
 }
 else if(quantityavailable == 8){
   
    return  DropdownButton<String>(
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
    value: details[cosToken] !=null ?details[cosToken]:menu,
    items: <String>["1","2","3","4","5","6","7","8",].map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),

  onChanged: (value) {
    setState(() { 
      details[cosToken] = value;
          
        });
  },
);
 }
 else if(quantityavailable == 7){
   
    return  DropdownButton<String>(
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
    value: details[cosToken] !=null ?details[cosToken]:menu,
    items: <String>["1","2","3","4","5","6","7",].map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),

  onChanged: (value) {
    setState(() { 
      details[cosToken] = value;
          
        });
  },
);
 }
 else if(quantityavailable == 6){
   
    return  DropdownButton<String>(
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
    value:details[cosToken] !=null ?details[cosToken]: menu,
    items: <String>["1","2",].map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),

  onChanged: (value) {
    setState(() { 
      details[cosToken] = value;
          
        });
  },
);
 }
 else{
   return Container(
     decoration: BoxDecoration(
       border: Border.all(color: Colors.red, width: 2),
       borderRadius: BorderRadius.circular(5.0)
     ),
     child: Text('Item out of stock'),
   );
 } 
 }
else if (quantityorder<=quantityavailable){
if (measure == "2"){
return Row(
  children: <Widget>[
    Container(
     decoration: BoxDecoration(
       color: Colors.grey[300],
       border: Border.all(color: Colors.grey[300], width: 2),
       borderRadius: BorderRadius.circular(5.0)
     ),
     child: Text('Size: ${quantityorder.toString()} g'),
   )
  ],
);
}
else if (measure == "3"){
return Row(
  children: <Widget>[
    Container(
     decoration: BoxDecoration(
       color: Colors.grey[300],
       border: Border.all(color: Colors.grey[300], width: 2),
       borderRadius: BorderRadius.circular(5.0)
     ),
     child: Text('Size: ${quantityorder.toString()} ml'),
   )
  ],
);
}

}
 else{
   return Container(
     decoration: BoxDecoration(
       border: Border.all(color: Colors.red, width: 2),
       borderRadius: BorderRadius.circular(5.0)
     ),
     child: Text('Item out of stock'),
   );
 }

}



price({price, dis, measure,quantityorder,len, cosToken}){

if (dis == null){
  if (measure == "1"){
    
    p1 = price * int.parse(details[cosToken] !=null ?details[cosToken]:menu);
    return Text("₹ ${p1.toString()}");
  }
  else {
    price = price * quantityorder;
    return Text("₹ ${price.toString()}");  
}
  
}
else if (dis != null){
 
 if(measure=="1"){
   var price1 = price * int.parse(details[cosToken] !=null ?details[cosToken]:menu);
   
   s1 = price1*dis~/100;
   price = price1 - price1*dis~/100;
   
   return Row(
     children: <Widget>[
       Text("₹ ${price.toString()}"),
       SizedBox(width: 5,),
       Text("₹ ${price1.toString()}", style: TextStyle(
         decoration: TextDecoration.lineThrough
       ),),
       SizedBox(width: 5,),
       Text("$dis% OFF", style: TextStyle(
     color: Colors.red
   ), )
     ],
   ); 
 }

 else{
   return Text('Sorry there is some error', style: TextStyle(
     color: Colors.red
   ),);
}


}
}

}