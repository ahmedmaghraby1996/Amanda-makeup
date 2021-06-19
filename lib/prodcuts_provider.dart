import 'dart:convert';

import 'package:Makeup_app/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class Prodcuts_Provider with ChangeNotifier{
List<Products> latestproducts,offers,prodcuts,spare=List(),spare2=List();
bool filter=false,isloading=false,clicked=false;
String tips,cobun,tipslabel,tips_image;
click(){
  clicked=true;
  notifyListeners();
}
filteron(){
  filter=true;
}
gettips()async{
  var response= await http.get("http://www.amanda-makeup.com/api/tips");
  var obj = jsonDecode(response.body);
  tipslabel= (obj[0]["tip_label"] as String);
  tips= (obj[0]["tip_body"] as String);
  tips_image= (obj[0]["tip_image"] as String);

  notifyListeners();
}
getcobun()async{
  var response= await http.get("http://www.amanda-makeup.com/api/getcobun");
  var obj = jsonDecode(response.body);
 cobun= (obj[0]["cobun"] as String);
  notifyListeners();
}

  getlatest()async{
    var response= await http.get("http://amanda-makeup.com/api/latest");
    var obj = jsonDecode(response.body);
    latestproducts= (obj["data"] as List<dynamic>).map((e) => Products(color_code: e["color_code"],size: e["size"],name: e["name"],brand: e["brand"], price: e["price"], image: e["image"], color: e["color"], details: e["details"], link: e["link"], offer: e["offer"], product: e["product"])).toList();
notifyListeners();
  }

clearspear(){
  spare.clear();
}
getoffers()async{
  var response= await http.get("http://amanda-makeup.com/api/getoffers/null/null/null/null");
  var obj = jsonDecode(response.body);
  offers= (obj["data"] as List<dynamic>).map((e) => Products(color_code: e["color_code"],size: e["size"],name: e["name"],brand: e["brand"], price: e["price"], image: e["image"], color: e["color"], details: e["details"], link: e["link"], offer: e["offer"], product: e["product"])).toList();
  notifyListeners();
}
 getpage(int page,String view,String search,String price,String brand,String product)async{


var response1;
print(view);
   if(brand=="all")
     brand="/null";
   if(price=="")
     price="/null";
   if(product==null)
     product="/null";
   if(search=="")
     search="/null";
   view=="offers"? response1= await http.get("http://amanda-makeup.com/api/getoffers${search}${product}${price}${brand}?page=${page.toString()}"): view=="latest"?  response1= await http.get("http://amanda-makeup.com/api/getproduct${search}${product}${price}${brand}?page=${page.toString()}"): response1= await http.get("http://amanda-makeup.com/api/getproduct${search}${product}${price}${brand}?page=${page.toString()}");

   var obj2 = jsonDecode(response1.body);
   int x= (obj2["last_page"] as int);
   int y= (obj2["current_page"] as int);

  if(y>x)
    return;



if(filter==false){
  if(y==2)

    if(view=="offers"){
spare.addAll(  offers);}
    else if (view=="latest"){
      spare.addAll( latestproducts);
}
    else

      spare.addAll(prodcuts);}


spare2= (obj2["data"] as List<dynamic>).map((e) => Products(color_code: e["color_code"],size: e["size"],name: e["name"],brand: e["brand"], price: e["price"], image: e["image"], color: e["color"], details: e["details"], link: e["link"], offer: e["offer"], product: e["product"])).toList();

  spare.addAll(spare2);
print(spare.length.toString());
filter=true;
  notifyListeners();

}

getprodduct(String category)async{
  var response= await http.get("http://amanda-makeup.com/api/getproduct/null${category}/null/null");
  var obj = jsonDecode(response.body);
  prodcuts= (obj["data"] as List<dynamic>).map((e) => Products(color_code: e["color_code"],size: e["size"],name: e["name"],brand: e["brand"], price: e["price"], image: e["image"], color: e["color"], details: e["details"], link: e["link"], offer: e["offer"], product: e["product"])).toList();
  notifyListeners();
}

nullproduct(){
    prodcuts=null;
    notifyListeners();
}
offfliter(){
    filter=false;
}



searchname(String view,String search,String price,String brand,String product)async{
filter=true;
if(brand=="all")
  brand="/null";
if(price=="")
  price="/null";
if(product==null)
  product="/null";
if(search=="" || search=="/")
  search="/null";


var response;

if(view=="offers")
  response= await http.get("http://amanda-makeup.com/api/getoffers${search}${product}${price}${brand}");
else
   response= await http.get("http://amanda-makeup.com/api/getproduct${search}${product}${price}${brand}");

  var obj = jsonDecode(response.body);
  spare= (obj["data"] as List<dynamic>).map((e) => Products(color_code: e["color_code"],size: e["size"],name: e["name"],brand: e["brand"], price: e["price"] , image: e["image"], color: e["color"], details: e["details"], link: e["link"], offer: e["offer"], product: e["product"])).toList();
  notifyListeners();

}


}