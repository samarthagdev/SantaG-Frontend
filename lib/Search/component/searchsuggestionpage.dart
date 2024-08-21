import 'package:AgrawalSeller/Search/component/searchresult.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:spell_checker/spell_checker.dart';
import 'package:AgrawalSeller/models/Categories_modle.dart';

class NewSearchBar extends StatefulWidget {
  @override
  _NewSearchBarState createState() => _NewSearchBarState();
}

class _NewSearchBarState extends State<NewSearchBar> {
  TextEditingController text1 = TextEditingController();

  List<ProductModel> alldataname = [];
  List<String> suggestion = [];
  //List<String> suggestion1 = [];
  List<String> suggestion2 = [];
  var items = List<String>();
  var checker = new SingleWordSpellChecker(distance: 1.0);
  var findlist;
  bool searching = true;

  Future<dynamic> getSearch() async {
    final response = await http.get(
        Uri.encodeFull("https://www.agrawalindustry.com/api/cosmatic/"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonresponse = json.decode(response.body);
      for (var data in jsonresponse) {
        alldataname.add(new ProductModel(data['cosBrand'], data['cosName']));
      }
      alldataname.forEach((element) {
        suggestion.add(element.cosName);
        suggestion.add(element.cosBrand);
        // suggestion1.add(element.csoName.toLowerCase());
        // suggestion1.add(element.cosBrand.toLowerCase());
      });
      suggestion = suggestion.toSet().toList();
      suggestion.forEach((element) {
        var word = element.split(" ");
        word.forEach((element) {
          suggestion2.add(element.toLowerCase());
        });
      });

      checker.addWords(suggestion2);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> getsearch1;

  @override
  void initState() {
    getsearch1 = getSearch();

    super.initState();
  }
  // @override
  // void dispose() {
  //   text1.dispose();
  //   super.dispose();
  // }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(suggestion);

    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
    } else {
      setState(() {
        items.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                color: Color(0xFF21BFBD),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Material(
                  elevation: 5,
                  child: TextField(
                    controller: text1,
                    onChanged: (value) {
                      setState(() {
                        filterSearchResults(value.toLowerCase());
                      });
                    },
                    autofocus: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        hintText: 'You can Search Here',
                        prefixIcon: Material(
                          elevation: 0,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        suffixIcon: Material(
                          elevation: 0,
                          // borderRadius: BorderRadius.circular(30.0),
                          child: IconButton(
                            onPressed: () {
                              var querry = text1.text.toLowerCase();
                              for (var x in suggestion) {
                                if (x.toLowerCase().contains(querry)) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchResult(
                                                querry1:
                                                    'api/cosmaticsearch?search=$querry',
                                                querry2: querry,
                                              )));
                                  searching = false;
                                  break;
                                }
                              }
                              var lis = querry.split(" ");
                              var querry1 = '';
                              for (var x in lis) {
                                findlist = checker.find(x);

                                if (findlist.isNotEmpty) {
                                  var y = findlist[0].toString();
                                  y = y.substring(0, y.indexOf(':'));
                                  querry1 = querry1 + " " + y;
                                }
                              }
                              if (searching) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchResult(
                                              querry1:
                                                  'api/cosmaticsearch?search=$querry1',
                                              querry2: querry1,
                                            )));
                              }

                              searching = true;
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${items[index]}',
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.playfairDisplay(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20)),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(
                                      querry1:
                                          'api/cosmaticsearch?search=${items[index]}',
                                      querry2: items[index],
                                    )));
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
