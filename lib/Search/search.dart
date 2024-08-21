import 'package:flutter/material.dart';
import 'package:AgrawalSeller/Search/component/searchsuggestionpage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode search;
  var s = false;
  
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    search = FocusNode();
  }
  
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    search.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          elevation: 5.0,
          
          borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              showCursor: false,
              focusNode: search,
              onTap: (){
                search.unfocus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewSearchBar())).then((value) => setState(() {}));
              },
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                hintText: 'You Can Search Here',
                suffixIcon: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                border: InputBorder.none
              ),
              
            ),
          
          ),
      );    
  }
}



  
