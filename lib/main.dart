import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AgrawalSeller/Login/login.dart';
import 'package:AgrawalSeller/sidebar/Storage.dart';
import 'package:AgrawalSeller/signup/signup.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'sidebar/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var status;
  final _url = 'https://play.google.com/store/apps/details?id=com.agrawalindustry';
  Future<dynamic> createAlbum1(number, token, approval, version) async {
  if (approval == true){
  final dynamic response = await http.post(
    'https://www.agrawalindustry.com/broadcast/landingpage',
    
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    
    body: json.encode(<String, dynamic>{
      
      "username":number,
      "token":token,
      "version":version
    }),

  );

  if(response.statusCode == 200){
    status = 200;
    return  [200];
  } 
  else if(response.statusCode == 205){
    return  [205];
  }
  else{
    return  [400];
  }
  }
  else{
    return [400];
  }

  }
  
  SecureStorage secureStorage = SecureStorage();
  var _token;
  var _number;

Future<dynamic> login;   
  
  @override
  void initState() {
    super.initState();
    login = setText();
    
  }
  
  Future<dynamic>setText() async{
    await secureStorage.readSecureData('token').then((value)  {
        _token =  value;  
    });
    await secureStorage.readSecureData('number').then((value)  {
      _number = value;
      
    });
    final PackageInfo _info = await PackageInfo.fromPlatform();
    
    if (_token!= null || _number != null){
    return createAlbum1(_number, _token, true, _info.version);
    }
    else{
      return createAlbum1(_number, _token, false, _info.version);
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<dynamic>(
        future: login,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            if (snapshot.data[0] == 400){
              return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Welcome', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),),
                      SizedBox(height: 30,),
                      Text('Automatic identity verification which enables you to verify your identity', textAlign: TextAlign.center,
                       style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(

                    image: DecorationImage(
                      
                      image: AssetImage("assets/illustration.jpg.png") 
                    )
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 5,),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text('Login', style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18


                      ),
                      ),
                    ),
                  SizedBox( height: 20,),
                  Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        top:BorderSide(color: Colors.black),
                        bottom:BorderSide(color: Colors.black),
                        right:BorderSide(color: Colors.black),
                        left:BorderSide(color: Colors.black), )

                    ),
                    child:MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                      },
                      color: Colors.yellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text('Sign Up', style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18


                      ),
                      ),
                    ),
                  )],
                )
                ],    
                ),
            ),
          ),
            
          
        );
            }
            else if (snapshot.data[0] == 200){
               
         WidgetsBinding.instance.addPostFrameCallback((_) {
       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
            }

            else if(snapshot.data[0] == 205){
                       WidgetsBinding.instance.addPostFrameCallback((_) {
                         return _showCompulsoryUpdateDialog(context, "A newer version of the app is available. After, update close the App and reopen it.");
                         });

            }
            else if (snapshot.hasError){
              return Center(
              child: Text(
              '${snapshot.error} occured',
              style: TextStyle(fontSize: 18),
            ),
          );
            }

          }

          
            return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoadingBouncingGrid.square(
                      borderColor: Colors.cyan,
                      size: 80,
                      inverted: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Checking your Identity ...', style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),),
                    
          ],
        ),
      );
            
          

        },
        
        ),
    );
       
    
      
  }
void _onUpdateNowClicked() async{
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

_showCompulsoryUpdateDialog(context, String message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "App Update Available";
        String btnLabel = "Update Now";
        return AlertDialog(
                title: Text(
                  title,
                  style: TextStyle(fontSize: 22),
                ),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: _onUpdateNowClicked,
                  ),
                ],
              );
      },
    );
  }


}