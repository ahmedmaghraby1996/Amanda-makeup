
import 'package:Makeup_app/prodcuts_provider.dart';
import 'package:Makeup_app/products.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget{
  Products product;
  Details(this.product);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

return Details_State();
  }

}
class Details_State extends State<Details>{
  String cobun;
  bool show =false;
  Products product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Prodcuts_Provider>(context,listen: false).getcobun();
    product= widget.product;
  }
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    cobun= Provider.of<Prodcuts_Provider>(context).cobun;

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(

    body:cobun==null? Center(child: CircularProgressIndicator(),): ListView(
      children: [
        Container(width: double.infinity,height: MediaQuery.of(context).size.height/2,child: Image.network("http://amanda-makeup.com/images/${product.image}",fit: BoxFit.cover)),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.name,style: TextStyle(fontSize: 18),),

          ),
        ),
   Card(
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: product.offer==null?Text("Price : ${
           product.price.toString() } L.E",style: TextStyle(fontSize: 18),):Text("Price : ${(product.price - (product.price * product.offer / 100)).round().toString()} L.E  (${(product.price * product.offer / 100).round()} L.E)  saved",style: TextStyle(fontSize: 18),),

     ),
   ),
       product.size==null?Container(): Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(" Size : ${product.size}",style: TextStyle(fontSize: 17),),

          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Description : ${product.details}",style: TextStyle(fontSize: 16),),

          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Color : ${product.color}",style: TextStyle(fontSize: 16),),SizedBox(width: 20,),
            product.color_code==null?Container():    Container(height: 30,width: 90,decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black),color: Color.fromRGBO(int.parse(product.color_code.substring(0,3)),int.parse(product.color_code.substring(4,7)),int.parse(product.color_code.substring(8,11)),1)),)
              ],
            ),

          ),
        ),
SizedBox(height: 20,),
        Container(

          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),),
          width: MediaQuery.of(context).size.width/1.2,
          child: Card(
            color:  Colors.redAccent,
            child:
            FlatButton(

              onPressed: (){setState(() {
                InterstitialAd(

                    adUnitId: "ca-app-pub-8624410529269642/4961271111",




                    listener: (MobileAdEvent event) {

                    })..load()..show(

                );
                show=true;
              });},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Text("Discount Cobone",style: TextStyle(color: Colors.white,fontSize: 19),),
                  Icon(Icons.grade,color: Colors.white,size: 27,)
                ],
              ),),


          ),
        ),
        Row(
          children: [
            SizedBox(width: 5,),
            Icon(Icons.info_outline),
            SizedBox(width: 5,),
            Text("use this cobone when buying")
          ],
        ),
        SizedBox(height: 20,),
        show==false? Container():
        SizedBox(height: 10,),
        show==false? Container():
        Container(padding: EdgeInsets.all(12),
          color: Colors.white,
          child: SelectableText(

            cobun
            ,style: TextStyle(fontSize: 18),),),SizedBox(height:20),
RaisedButton(onPressed: ()async{await launch(product.link,enableJavaScript: true,forceWebView: true);},color: Colors.deepOrange,child: Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Text("BUY NOW",style: TextStyle(color:Colors.white,fontSize: 25),),
),)



      ],
    ),
  );
  }
}