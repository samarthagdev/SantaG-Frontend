import 'dart:ffi';
class CategoriesPage {

String img;
String name;
CategoriesPage({this.img, this.name});

}

class SpecialOfferPage {
  String img;
  String productname;
  int price;
  Float dis;
}


class ProductModel{
  String cosBrand;
  String cosName;

  ProductModel(this.cosBrand, this.cosName);
}

class Menucard {
   var img;
   var post;
  Menucard(this.img, this.post);
 }
