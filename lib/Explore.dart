import 'package:Makeup_app/details.dart';
import 'package:Makeup_app/prodcuts_provider.dart';
import 'package:Makeup_app/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class Explore extends StatefulWidget {
  String category, view;

  Explore({this.category, this.view});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExploreState();
  }
}

class ExploreState extends State<Explore> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Products> products;
  List<String> Categoryclass=["Skin Care","Hair","Blush","Concealer","Powder","Foundation","Lipstick","Lip Pen","Lip Balm","Mascara","Eyeliner","Eyeshadow","Nail Care","Nail Polish","Nail Polish Remover"];
  List filters = List();
  String product;

  String category, order=""  , view,search="";
  String brand = "all";
  bool isLoading=false,loading=false ;
  int pageCount = 1;
  ScrollController _scrollController;
  TextEditingController _controller;
  bool myInterceptor(_, RouteInfo info) {
    Provider.of<Prodcuts_Provider>(context, listen: false).offfliter();
    // Provider.of<Prodcuts_Provider>(context, listen: false).clearspear();
    Navigator.of(context).pop(); // Do some stuff.
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Prodcuts_Provider>(context, listen: false).clearspear();
_controller=TextEditingController(text: search);
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    BackButtonInterceptor.add(myInterceptor);
    if (widget.category != null) {
      category = widget.category;
product=category;
      Provider.of<Prodcuts_Provider>(context, listen: false)
          .getprodduct(category);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.remove(myInterceptor);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();

  }_scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {

        isLoading = true;

        if (isLoading) {


          pageCount = pageCount + 1;
print(pageCount.toString());
          Provider.of<Prodcuts_Provider>(context,listen: false).getpage(pageCount,view,search,order,brand,product).then((_){
            setState(() {
              isLoading=false;
            });
          });
        }
      });
    }
  }
  searchfun(){
    setState(() {
      pageCount=1;
      loading=true;
    });


    Provider.of<Prodcuts_Provider>(_scaffoldKey.currentContext,listen: false).searchname(  view,search,order,brand,product).then((_){
      setState(() {

        loading=false;
      });
    });
  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    products = Provider.of<Prodcuts_Provider>(context).prodcuts;
    if (widget.view != null) {
      view = widget.view;
      if (view == "offers")
        products = Provider.of<Prodcuts_Provider>(context).offers;
      else
        products = Provider.of<Prodcuts_Provider>(context).latestproducts;
    }
    if (Provider.of<Prodcuts_Provider>(context).filter == true)
      products = Provider.of<Prodcuts_Provider>(context).spare;
    if(Provider.of<Prodcuts_Provider>(context).spare.length!=0)
      products = Provider.of<Prodcuts_Provider>(context).spare;
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _scaffoldKey,
      body: products == null || loading==true
          ? Center(child: CircularProgressIndicator())
          :
               ListView(
                  children: [
                    TextField(
                      controller:   _controller,
                      onSubmitted: (v){

                        setState(() {
                          search="/${v}";
                        });
                        searchfun();
                      },

                      decoration: InputDecoration(

                          labelText: "Search here",
                          prefixIcon: Icon(Icons.search)),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: ListTile(
                          title: Text("Filters"),
                          leading: Icon(Icons.settings),
                          onTap: ()=>showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: _scaffoldKey.currentContext, builder: (context)=>
                          StatefulBuilder(
                            builder:(BuildContext context, StateSetter setState)=> Container(
                              height: MediaQuery.of(_scaffoldKey.currentContext).size.height*.9 ,
    decoration: new BoxDecoration(
    color: Colors.white,
    borderRadius: new BorderRadius.only(
    topLeft: const Radius.circular(25.0),
    topRight: const Radius.circular(25.0),
    ),),
                              child: Column(children: [
                          view==null?Container():      Container(

                            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2,color: Colors.grey))),
                                  width: double.infinity,
                                  height: MediaQuery.of(_scaffoldKey.currentContext).size.height*.9-400,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Products:",style: TextStyle(fontSize: 23),),
                                      Container(
                                        width: 200,
                                        height: MediaQuery.of(_scaffoldKey.currentContext).size.height*.9-400,
                                        child: ListView(
                                          children: Categoryclass.map((e) => RadioListTile(
                                              title: Text(
                                                  e),
                                              value: "/${e.toLowerCase().replaceAll(" ", "")}",
                                              groupValue: product,
                                              onChanged: (v) {
                                                setState(() {
                                                  product = v;

                                                });
                                              }) ).toList()





                                          ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                Container(
                                  height: 180,
                                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color: Colors.grey))),
                                  child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Brand:",style: TextStyle(fontSize: 22),
                                      ),
                                      Container(
                                        width: 200,
                                        height: 150,
                                        child: ListView(
                                          children: [
                                            RadioListTile(
                                                title: Text("All"),
                                                value: "all",
                                                groupValue: brand,
                                                onChanged: (v) {
                                                  setState(() {
                                                    brand = v;
                                                  });
                                                }),
                                            RadioListTile(
                                                title: Text("Amanda"),
                                                value:
                                                "/Amanda Milano",
                                                groupValue: brand,
                                                onChanged: (v) {
                                                  setState(() {
                                                    brand = v;
                                                  });
                                                }),
                                            RadioListTile(
                                                title: Text("Luna"),
                                                value: "/luna",
                                                groupValue: brand,
                                                onChanged: (v) {
                                                  setState(() {
                                                    brand = v;
                                                    print(brand);
                                                  });
                                                }),
                                            RadioListTile(
                                                title: Text("Others"),
                                                value: "/others",
                                                groupValue: brand,
                                                onChanged: (v) {
                                                  setState(() {
                                                    brand = v;
                                                    print(brand);
                                                  });
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(

                                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color: Colors.grey))),
                                  height: 120,
                                  width: double.infinity,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Price:",style: TextStyle(fontSize: 22),),
                                      Container(
                                        height: 120,
width: 200,
                                        child: ListView(
                                          children: [


                                            RadioListTile(
                                                title: Text(
                                                    "Lower to Higher"),
                                                value: "/low",
                                                groupValue: order,
                                                onChanged: (v) {
                                                  setState(() {
                                                    order = v;
                                                  });
                                                }),
                                            RadioListTile(
                                                title: Text(
                                                    "Higher to Lower"),
                                                value: "/high",
                                                groupValue: order,
                                                onChanged: (v) {
                                                  setState(() {
                                                    order = v;
                                                  });
                                                }),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 SizedBox(height: 10,),
                                 RaisedButton(child: Text("Done"),onPressed: (){
searchfun();

print(order);
    Navigator.of(context,rootNavigator: true).pop();

    },),


                              ],),
                            ),
                          ),),

                        ),),

                    products.length == 0
                        ? Center(
                      child: Text(
                        "No Products Found ",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ):      Container(
                        height:MediaQuery.of(context).size.height * 3.3 / 4,
                        child: Stack(
                          children: [
                            GridView.count(
                              controller: _scrollController,

                              physics: const AlwaysScrollableScrollPhysics(),
                              childAspectRatio: 2.6 / 4,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              crossAxisCount: 2,
                              children: [...products
                                  .map((e) => InkWell(
                                        onTap: ()  {

                                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>   Details(e)));

                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(3.0),
                                          child:
                                          Stack(
                                            children: [
                                              Card(
                                                  child: Column(
                                                children: [
                                                  Container(
                                                      width: double.infinity,
                                                      child: Image.network(
                                                        "http://amanda-makeup.com/images/${e.image}",
                                                        fit: BoxFit.cover,
                                                      )),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Text(e.name,
                                                        maxLines: 2,
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.exo(
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                  ),
                                                  Text(
                                                    e.offer == 0
                                                        ? "${e.price.toString()} L.E"
                                                        : " ${(e.price - (e.price * e.offer / 100)).round().toString()} L.E",
                                                    style: GoogleFonts.exo(fontSize: 16),
                                                  ),
                                                  e.offer == 0
                                                      ? Container()
                                                      : Text(
                                                          "${e.price.toString()} L.E",
                                                          style: GoogleFonts.exo(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: Colors.grey),
                                                        )
                                                ],
                                              )),
                                              e.offer == 0
                                                  ? Container()
                                                  : Positioned(
                                                      right: 5,
                                                      top: 5,
                                                      child: CircleAvatar(
                                                          radius: 14,
                                                          child: Text(
                                                            "${e.offer.toString()}%",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                    ),
                                              e.color_code==null?Container():      Banner(
                                                color: Color.fromRGBO(int.parse(e.color_code.substring(0,3)),int.parse(e.color_code.substring(4,7)),int.parse(e.color_code.substring(8,11)),1),
                                                location: BannerLocation.topStart,
                                                message: e.color,
                                                textStyle: TextStyle(shadows:<Shadow>[
    Shadow(
    offset: Offset(1.0, 1.0),
    blurRadius: 2.0,
    color: Colors.black
    ) ]),
                                              )
                                            ],
                                          ),

                                        ),
                                      ))
                                  .toList(),
                              Text(""),Text("")]

                            ),

                            isLoading==true ?Center(child: Align(alignment: Alignment(0,.5),child: CircularProgressIndicator()),):Container()
                          ],

                        ))


                  ],
                ),
    );

  }
}
