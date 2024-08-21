import 'dart:ui';
import 'package:AgrawalSeller/Bag/bag.dart';
import 'package:AgrawalSeller/Search/component/product.dart';
import 'package:AgrawalSeller/Search/component/searchsuggestionpage.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:AgrawalSeller/sidebar/Storage.dart';

class SearchResult extends StatefulWidget {
  final querry1;
  final querry2;
  SearchResult({this.querry1, this.querry2});
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  var jsonresponse;
  final SecureStorage _storage1 = SecureStorage();
  var number;

  Future<dynamic> getSearch() async {
    final response = await http.get(
        Uri.encodeFull("https://www.agrawalindustry.com/${widget.querry1}"),
        headers: {
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      jsonresponse = json.decode(response.body);
      if (jsonresponse is List) {
        return jsonresponse;
      } else {
        jsonresponse['cosImage1'] =
            "https://www.agrawalindustry.com" + jsonresponse['cosImage1'];
        jsonresponse = [jsonresponse];
        return jsonresponse;
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> futureSearch;

  @override
  void initState() {
    super.initState();

    _storage1.readSecureData('number').then((value) {
      number = value;
    });
    futureSearch = getSearch();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF21BFBD),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 15),
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewSearchBar()));
              }),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Badge(
              position: BadgePosition.topEnd(top: 0, end: 0),
              alignment: Alignment.center,
              badgeColor: Colors.red,
              animationType: BadgeAnimationType.fade,
              badgeContent: null,
              child: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Bag(
                                number: number,
                              ))).then((_) {});
                },
              ),
            ),
          ),
        ],
        title: Text(widget.querry2),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: futureSearch,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(

                //shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var apidata = snapshot.data[index];
                  var cosPrice = apidata['cosPrice'].toString();
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Productdetails(detail: apidata['cosToken'])));
                    },
                    child: Card(

                        //semanticContainer: false,
                        elevation: 5.0,
                        child: Container(
                          //margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500]),
                              //borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Image.network(
                                  '${apidata['cosImage1']}',
                                  height: 141,
                                  width: double.infinity,
                                ),
                              ),
                              Container(
                                child: Text(apidata["cosBrand"],
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: GoogleFonts.playfairDisplay(
                                      textStyle: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                              Container(
                                  child: Text(apidata["cosName"],
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1)),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: 90,
                                  child: apidata['cosDis'] == null
                                      ? Text(
                                          '₹$cosPrice',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        )
                                      : priceDis(
                                          cosPrice: apidata['cosPrice'],
                                          cosDis: apidata['cosDis']))
                            ],
                          ),
                        )),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget priceDis({cosPrice, cosDis}) {
    var dis = cosPrice - (cosPrice * cosDis) ~/ 100;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('₹$dis',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text('₹$cosPrice',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                  fontSize: 15,
                  decoration: TextDecoration.lineThrough)),
        ),
      ],
    );
  }
}
