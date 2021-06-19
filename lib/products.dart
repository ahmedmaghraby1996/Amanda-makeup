import 'package:flutter/cupertino.dart';


import 'dart:convert';
class Products {
  String brand,product,color,image,details,link,size,name,color_code;
  int id,offer,price;
  Products({@required this.color_code,@required this.size,@required this.brand,@required this.price,this.name,this.id,@required this.image,@required this.color,@required this.details,@required this.link,@required this.offer,@required this.product})  ;
}


