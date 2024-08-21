import 'dart:convert';
import 'package:AgrawalSeller/sidebar/sidebar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  final username;
  final password;
  final number;
  final page;
  OtpPage({this.username,this.password,this.number, this.page});
  @override
  _OtpPageState createState() => _OtpPageState();
}



class _OtpPageState extends State<OtpPage> {
  final otpcontroller = TextEditingController();
  
  bool _validate = false;
  var code = 200;
  var response2;
  Future<dynamic> createAlbum(username, number, password,otp) async {
  final dynamic response = await http.post(
    'https://www.agrawalindustry.com/broadcast/otpchecking',
    
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: json.encode(<String, dynamic>{
      "userName":username,
      "number":number,
      "password": password,
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

else if(response.statusCode == 404){
  setState(() {
  code = 404;  
  });
  
  Navigator.pop(context);

} 

else if (response.statusCode == 200){
  
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(ui:jsonDecode(response.body), page: 'otp',number: number,))
,(Route<dynamic> route) => false);
  }
  }


Future<dynamic> createAlbum1(number, otp) async {
  final dynamic response = await http.post(
    'https://www.agrawalindustry.com/broadcast/forgototp',
    
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: json.encode(<String, dynamic>{
      
      "username":number,
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

else if(response.statusCode == 404){
  setState(() {
  code = 404;  
  });
  
  Navigator.pop(context);

} 

else if (response.statusCode == 200){

 
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(ui: jsonDecode(response.body),page: 'otp',number: number,)),
(Route<dynamic> route) => false);
  }
  }
  
  
  
  @override
  void initState() {
    
    super.initState();
  }
  // Future<dynamic> _checkotp;
  @override
  Widget build(BuildContext context) {
    
    
    int otp;
    
    
    void _setText1() { 
    setState(() {
      try{ 
      otp = int.parse(otpcontroller.text);
      }
      on Exception {
      otp = 0;
      }
    });}

    

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("OTP Verification", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400
                    ),)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(height: 300,image: AssetImage(
                      'assets/otpboy.png',
                    ),)
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Enter the verification Code we just sent \n      to you on your Mobile number",overflow: TextOverflow.ellipsis, style: TextStyle(
                      fontSize: 20,
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
                                  otpcontroller.text.isEmpty ? _validate = true : _validate = false;
                                  if(otpcontroller.text.isNotEmpty){
                                  
                                  if (widget.page == 'login') {
                                  createAlbum1(widget.number, otp);  
                                  }
                                  else{
                                    createAlbum(widget.username,widget.number,widget.password, otp);
                                  } 
                                  
                                  
                                                                    
                                  }
                                },
                                minWidth: MediaQuery.of(context).size.width/1.2,
                                height: 60,
                                color: Colors.blueAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text('Resister Account', style: TextStyle(
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
      ),
    );  
}

status(){

    if(code == 400 || code == 404){
    
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
                      width: MediaQuery.of(context).size.width/2,
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
          controller: otpcontroller,

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
                      width: MediaQuery.of(context).size.width/2,
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
          controller: otpcontroller,

                        ),
                      ),
                  ],
                );
  }   
  
  }
}