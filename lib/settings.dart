import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class Settings extends StatefulWidget {
final username;
final Function selectIndicater;
final number;
  Settings({this.number,this.selectIndicater, this.username});
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

Future <dynamic> setpass({number, name, password1}) async{
    
    final response = await http.post(Uri.encodeFull("https://www.agrawalindustry.com/usercorrections/Setpass/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
     body:jsonEncode(<String, dynamic>{
       "number":number,
       "username":name,
       "password":password1,
     } 
    ));
    if (response.statusCode == 200) {
      bottomsheet(context);
    }
    else {
    throw Exception('Failed to load album');
  }        
  }

void bottomsheet(contex){
showDialog(
  context: context,
  builder: (ctx) =>AlertDialog(
    title: Text('Setting Saved', textAlign: TextAlign.center,),
    backgroundColor: Colors.amber,
    content: Image.asset('assets/saved.png'),   
  )
  );}
var number;

TextEditingController name = TextEditingController();
TextEditingController password1 = TextEditingController();
TextEditingController password2 = TextEditingController();
bool _validate = false;
bool _validate1 = false;
bool _validate2 = false;
  Future<dynamic> cartitem;
  @override
  void initState() {
    
    super.initState();
    name = TextEditingController(text: widget.username);
    number = widget.number;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF21BFBD),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: (){
              Navigator.pop(context);
            }),
        ),
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
                     name.text.isEmpty ? _validate = true : _validate = false;
                     password1.text.isEmpty ? _validate1 = true : _validate1 = false;
                     password2.text.isEmpty ? _validate2 = true : _validate2 = false;  
                    });
                if (name.text.isNotEmpty && password1.text.isNotEmpty && password2.text.isNotEmpty && password1.text ==  password2.text){
                  setpass(number: number, password1: password1.text, name: name.text);
                }
              },
              child: Text('Save Changes', style: TextStyle(
                color:Colors.white,
                fontSize: 20,

              ),),
              ),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 15,),
            Container(
              child: Text(
                        'Profile Setting', style: GoogleFonts.merienda(
                                                      fontStyle: FontStyle.normal,
                                                      textStyle: TextStyle(
                                        // fontWeight:FontWeight.w600,
                                        color: Colors.blueGrey,
                                        fontSize: 30
                                        )
                           )),
            ),
            
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              
            ),
            Container(
                      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                      child: TextFormField(
                        // initialValue: addr != null? addr :null,
                        // keyboardType: TextInputType.multiline,
                        maxLines: null,
                         maxLength: 150,
                        controller: name,
                        decoration: InputDecoration(
                          errorText: _validate ? 'Field Can\'t Be Empty' : null,
                          hintText: "Name",
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
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                      child: TextFormField(
                        // initialValue: addr != null? addr :null,
                        // keyboardType: TextInputType.multiline,
                        obscureText: true,
                        // maxLines: null,
                         maxLength: 150,
                        controller: password1,
                        decoration: InputDecoration(
                          
                          errorText: _validate1 ? 'Field Can\'t Be Empty' : null,
                          hintText: "New Password",
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
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
                      child: TextFormField(
                        // initialValue: addr != null? addr :null,
                        // keyboardType: TextInputType.multiline,
                        obscureText: true,
                        // maxLines: null,
                         maxLength: 150,
                        controller: password2,
                        decoration: InputDecoration(
                          errorText: _validate2 ? 'Field Can\'t Be Empty' : null,
                          hintText: "Confirm New Password",
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
          ],
        ),
      ),
    );
  }
}