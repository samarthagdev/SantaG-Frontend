import 'dart:convert';

import 'package:AgrawalSeller/Login/login.dart';
import 'package:AgrawalSeller/signup/status.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:AgrawalSeller/signup/otp.dart';


  

class SignupPage extends StatefulWidget {
  
  final status;
  
  SignupPage({this.status});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
bool _s= false;
var code = 200;
var response2;
Future<dynamic> createAlbum(username, number, password,otp, number_trial) async {
  final dynamic response = await http.post(
    'https://www.agrawalindustry.com/broadcast/verification',
    
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: json.encode(<String, dynamic>{
      "userName":username,
      "number":number,
      "password": password,
      "otp":otp,
      "number_trial":number_trial
    }),
  );
  if(response.statusCode == 400){
  var response1 = jsonDecode(response.body);
  // Status(status: response1,code: 400,);
  setState(() {
  code = 400;
  response2 = response1;  
  });
  
   
  }
  else if( response.statusCode != 400){
    setState(() {
      code = 200;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(username: username, password: password,number: number)));
    }

  }  
  
  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;

  final passwordController = TextEditingController();
  final passwordController1 = TextEditingController();
  final usernameController = TextEditingController();
  final numberController = TextEditingController(); 
  
  var username;
  var number;
  var password;
  var otp;
  var number_trial;
  void _setText() { 
    setState(() { 
      var text1 = usernameController.text;
       username = text1;
       otp = '1';
       number_trial = 0;
    }); 
  

   
    setState(() { 
      number = numberController.text;
       
    }); 
  

   
    setState(() { 
      password = passwordController.text;
       
    }); 
  }  

  
  Future<dynamic> _futureotp;
  
  void initState() {
   super.initState();
   
}
@override
void dispose() {
  numberController.dispose();
  passwordController.dispose();
  passwordController1.dispose();
  usernameController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height-50,
          width: double.infinity,
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'SignUp', style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          
                        ), 
                      ),
                      Text(
                        'Create an account', style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700]
                        ),
                      ),
                      SizedBox(height: 40,),
                      Column(
                        children: <Widget>[
                          
                          



Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Status(status: response2,code: code,pass:_s,),
        SizedBox(height: 10,),
        Text(
          'User Name', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          maxLength: 70,
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
          
          controller: usernameController,
        )
      ],
    ),
SizedBox(height: 10,),
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
          
          controller: numberController,
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
          
          obscureText: true,
          decoration: InputDecoration(
            errorText: _validate2 ? 'Field Can\'t Be Empty' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide( color: Colors.grey[400])
            )

          ),
          
          controller: passwordController,
        )
      ],
    ),
SizedBox(height: 10,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5,),
        TextField(
          controller: passwordController1,
          obscureText: true,
          decoration: InputDecoration(
            errorText: _validate3 ? 'Field Can\'t Be Empty' : null,
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
                      ),
                    Column(
                      children: [
                        Container(
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
                              onPressed: ()  {
                                _setText();
                                numberController.text.isEmpty ? _validate1 = true : _validate1 = false;
                                passwordController1.text.isEmpty ? _validate3 = true : _validate3 = false;
                                usernameController.text.isEmpty ? _validate = true : _validate = false;
                                passwordController.text.isEmpty ? _validate2 = true : _validate2 = false;
                                if (passwordController1.text != passwordController.text ){
                                  _s = true;
                                }
                                if (passwordController1.text == passwordController.text && passwordController1.text.isNotEmpty&&numberController.text.isNotEmpty && usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
                                setState(() {
                                  createAlbum(username, number, password, otp, number_trial);
                                });
                                
                                }
                              
                              },
                              minWidth: double.infinity,
                              height: 60,
                              color: Colors.greenAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text('Signup', style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18


                        ),
                        ),

                            ),
                          ),
                          
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?"),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                          },
                          child: Text("Login", style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),),
                        )
                      ],
                    )

                    ],
                  ),
                ],
              ),
            ],
          ),
          
        ),
      ),
    );
  }
  
}