import 'package:flutter/material.dart';

class Hotel extends StatefulWidget {
  final item;
  Hotel({this.item});
  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
List<dynamic> images = [];
@override
  void initState() {
    super.initState();
    images = widget.item; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF21BFBD),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: (){
              Navigator.pop(context);
            }),
        ),
      body: SingleChildScrollView(
        child:Container(
              child:ListView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: images.length,
                    itemBuilder: (contex, index){
                      return Container(
                             margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                              child: Image.network(
                                'https://www.agrawalindustry.com${images[index]}',
                                fit: BoxFit.cover,
                                // height: MediaQuery.of(context).size.height,
                                
                                ),
                            );
                    }
                    )
                
                ),
            )
    );
  }
}