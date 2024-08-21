import 'package:AgrawalSeller/Bag/bag.dart';
import 'package:AgrawalSeller/Search/search.dart';
import 'package:AgrawalSeller/Items/items.dart';
import 'package:AgrawalSeller/sidebar/Storage.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:google_fonts/google_fonts.dart';
class UserDashPage extends StatefulWidget {
  @override
  _UserDashPageState createState() => _UserDashPageState();
}

class _UserDashPageState extends State<UserDashPage> {
  final SecureStorage _storage1 = SecureStorage();
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool button = false;
  var s;
var number;

  
  @override
  void initState() {
    
    super.initState();
     _storage1.readSecureData('number').then((value){
          number = value;  
          });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          else if(button == true){
            setState(() {
              xOffset = 0;
              yOffset = 0;
              scaleFactor = 1;
              button = false;
              });}
        },
        child: AnimatedContainer(

          duration: Duration(microseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor)..rotateY(button? -0.5:0),
          child: Scaffold(
            backgroundColor: Color(0xFF21BFBD),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Bag(number: number,)));
              },
              label: Text('BAG'),
              backgroundColor: Colors.amber,
              ),
            
            
            body: SafeArea(
                
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.menu),
                                color: Colors.white,
                                onPressed: (){
                                  if (button == false ) {
                                    setState(() {
                                    xOffset = 230;
                                    yOffset = 130;
                                    scaleFactor = 1;
                                    button = true;
                                  });  
                                  }
                                  else if(button == true){
                                    setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    button = false;

                                  });                
                                  }

                                },
                               ),
                               Container(
                                 width: 125.0,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: <Widget>[
                                    //  IconButton( 
                                    //   icon: Icon(Icons.add_alert),
                                    //    color: Colors.white,
                                    //    onPressed: (){},
                                    //   ),

                                      Badge(
                                        
                                          alignment: Alignment.topLeft,
                                          badgeColor: Colors.red,
                                          animationType: BadgeAnimationType.fade,
                                            badgeContent:null,
                                            child: IconButton(
                                              
                                         icon: Icon(Icons.add_shopping_cart),
                                         color: Colors.white,
                                         onPressed: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => Bag(number: number,)));
                                         },
                                        ),
                                          ),
                                          SizedBox(width: 15,)
                                   ],
                                 ),
                               )
                            ]
                          ), 
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              
                              Text('SantaG', textAlign: TextAlign.center,style: GoogleFonts.flavors(
                                                    fontStyle: FontStyle.normal,
                                                    textStyle: TextStyle(
                                      // fontWeight:FontWeight.w600,
                                      fontSize: 50,
                                      color: Colors.amber
                                      )
                         )),
                              Text('.', style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),)
                            ],
                          ),
                          ),
                          SizedBox(height: 20.0,),
                          SearchPage(),
                          SizedBox(height: 20.0,),
                        
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0),)
                          ),
                          child:Column(
                            children: <Widget>[
                                SizedBox(height: 30,),
                                DiffrentItems()
                            ],

                          ),
                          ),
                      ],
                    ),
                  ),
                
              ),
          ),
        ),
      );
    
  }
  void backpage(){
    Navigator.pop(context);
  }
}

