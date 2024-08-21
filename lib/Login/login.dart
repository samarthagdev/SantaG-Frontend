import 'dart:convert';
import 'package:AgrawalSeller/Login/forgot.dart';
import 'package:AgrawalSeller/sidebar/sidebar.dart';
import 'package:http/http.dart' as http;

import 'package:AgrawalSeller/signup/signup.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
var code = 200;
var response2;
Future<dynamic> createAlbum(number, password) async {
  final dynamic response = await http.post(
    'https://www.agrawalindustry.com/broadcast/login',
    
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: json.encode(<String, dynamic>{
      "username":number,
      "password": password,
      
    }),
  );


  if(response.statusCode == 200){
var res =jsonDecode(response.body);

  setState(() {
      code = 200;
    });
    
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>HomeScreen(ui: res['token'], page: 'login',number:number,)),
    (Route<dynamic> route) => false);
  
  
   
  }
  else {
    var response1 = 'You Entered Wrong Username and Password';
    setState(() {
      code = 400;
    });
    setState(() {
  code = 400;
  response2 = response1;  
  });
    }

  }
  bool _validate = false;
  bool _validate1 = false;
  TextEditingController _number = TextEditingController();
  TextEditingController _password = TextEditingController();
  
  var number;
  var password;

  void _setText() { 
    
    setState(() { 
      number = _number.text;
       
    }); 
    setState(() { 
      password = _password.text;
       
    }); 
  }
   void initState() {
   super.initState();
   
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed:(){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black, ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Login', style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        
                      ), 
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Login to your account', style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]
                      ),
                    ),
                    Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: status()
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                        margin: EdgeInsets.only(top:20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              top:BorderSide(color: Colors.black),
                              bottom:BorderSide(color: Colors.black),
                              right:BorderSide(color: Colors.black),
                              left:BorderSide(color: Colors.black), )

                          ),
                        child: MaterialButton(
                          onPressed: (){
                            _setText();
                            _number.text.isEmpty ? _validate = true : _validate = false;
                            _password.text.isEmpty ? _validate1 = true : _validate1 = false;

                            if (_number.text.isNotEmpty && _password.text.isNotEmpty){
                              createAlbum(number, password,);
                            }
                            
                          },
                          minWidth: double.infinity,
                          height: 60,
                          color: Colors.greenAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text('Login', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18


                    ),
                    ),

                        ),
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                        },
                        child: Text("Sign up", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),),
                      )
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Do you forgrt your Password?"),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPage()));
                        },
                        child: Text("Forgot Password", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),),
                      )
                    ],
                  )

                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/iphone1.png'),
                    fit: BoxFit.cover
                    )
                ),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
status(){

    if(code == 400 || code == 404){
    
    return Column(
                    children: <Widget>[
                
                     
                      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(response2,  style: TextStyle(
        color: Colors.red,
        fontSize: 12
          )),
        ),
        Text(
          'Mobile Number', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          controller: _number,
          decoration: InputDecoration(
            errorText: _validate ? 'Field Can\'t Be Empty' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            )

          ),
        )
      ],
    ),
                      
                      SizedBox(height: 10,),
                     
                      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          controller: _password,

          obscureText: true,
          decoration: InputDecoration(
            errorText: _validate1 ? 'Field Can\'t Be Empty' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            )

          ),
        )
      ],
    ),
                      
                      SizedBox(height:20,),
                      
                     ],
                  );
  }
  
  else if(code != 400){
  return Column(
                    children: <Widget>[
                
                     
                      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mobile Number', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          controller: _number,
          decoration: InputDecoration(
            errorText: _validate ? 'Field Can\'t Be Empty' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            )

          ),
        )
      ],
    ),
                      
                      SizedBox(height: 10,),
                     
                      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          controller: _password,

          obscureText: true,
          decoration: InputDecoration(
            errorText: _validate1 ? 'Field Can\'t Be Empty' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            )

          ),
        )
      ],
    ),
                      
                      SizedBox(height:20,),
                      
                     ],
                  );
  }   
  
  }

}