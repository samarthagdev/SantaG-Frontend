import 'package:AgrawalSeller/signup/otp.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
bool _validate = false;
  var code = 200;
  var response2;

TextEditingController _otpcontroller1 = TextEditingController();
  Future<dynamic> createAlbum1(number, otp, number_trial) async {
  final dynamic response = await http.post(
    'https://www.agrawalindustry.com/broadcast/hellow1',
    
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: json.encode(<String, dynamic>{
      
      "number":number,
      "number_trial": number_trial,
      "otp":otp,
      
      
      
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

else if (response.statusCode == 200){
Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(page: 'login',number: number,)));
  }
  }


var number;
var otp;
var number_trial;
void _setText1() { 
    setState(() { 
       otp = '1';
       number_trial = 0;
    }); 
  
    setState(() { 
      number = _otpcontroller1.text;
       
    }); 
  

   
     
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
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
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Enter Your Number",overflow: TextOverflow.ellipsis, style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w400
                    ),)
                  ],
                ),
                SizedBox(height: 15,),
                status(),
                SizedBox(height: 20,),
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
                                onPressed:  (){
                                  _setText1();
                                  _otpcontroller1.text.isEmpty ? _validate = true : _validate = false;
                                  if(_otpcontroller1.text.isNotEmpty){
                                  createAlbum1(number, otp, number_trial);
                                  
                                                                    
                                  }
                                },
                                minWidth: MediaQuery.of(context).size.width/1.2,
                                height: 60,
                                color: Colors.blueAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text('Reset', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18


                          ),
                          ),

                              ),
                            ),
              ],
            ),
          ),
        ),
    );
  }
status(){

    if(code == 400){
    
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
      child: Text(response2, style: TextStyle(
        color: Colors.red,
        fontSize: 12
      ),),
    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14.0)
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                        
                        decoration: InputDecoration(
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                           border: InputBorder.none,
                           
                           enabledBorder: InputBorder.none,
                           errorBorder: InputBorder.none,
                           disabledBorder: InputBorder.none,
                           contentPadding:EdgeInsets.only(left: 45, bottom: 11, top: 11, right: 15),
          hintText: "Enter Number"),
          controller: _otpcontroller1,

                        ),
                      ),
                  ],
                );
  }
  
  else if(code != 400){
  return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/2.7,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14.0)
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                        
                        decoration: InputDecoration(
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                           border: InputBorder.none,
                           
                           enabledBorder: InputBorder.none,
                           errorBorder: InputBorder.none,
                           disabledBorder: InputBorder.none,
                           contentPadding:EdgeInsets.only(left: 45, bottom: 11, top: 11, right: 15),
          hintText: "Enter OTP"),
          controller: _otpcontroller1,

                        ),
                      ),
                  ],
                );
  }   
  
  }
}