import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:Makeup_app/Explore.dart';
import 'package:Makeup_app/categories.dart';
import 'package:Makeup_app/details.dart';
import 'package:Makeup_app/main_category.dart';
import 'package:Makeup_app/prodcuts_provider.dart';
import 'package:Makeup_app/products.dart';
import 'package:Makeup_app/tips.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:floating_ribbon/floating_ribbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Makeup_app/loadingscreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';

import 'makeup.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.photos.request();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ChangeNotifierProvider(
    create: (_) => Prodcuts_Provider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amanda Makeup',
      theme: ThemeData(
          canvasColor: Color.fromRGBO(249, 243, 243, 1),
          primaryColor: Color.fromRGBO(67, 85, 96, 1.0)),
      home: LoadingScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  bool net=true;

  checknet()async{
    ConnectivityResult result =
        await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none)
      net=false;
  }
  int botindex = 0;
  List<Products> latestproducts, offers;

  TabController ctrl;
  TextStyle welcomeStyle = GoogleFonts.cairo(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 0,
      fontStyle: FontStyle.italic);

  int currentindex = 0,
      tabindex = 0;
  List<Color> colors = [Colors.white, Colors.white, Colors.white];

  bool clicked=false;
  playad(){
    InterstitialAd(

        adUnitId: "ca-app-pub-8624410529269642/2526679466",


        listener: (MobileAdEvent event) {

        })
      ..load()
      ..show(

      );
  }
  @override
  void initState() {
    super.initState();
    checknet();

    FirebaseAdMob.instance.initialize(
        appId: "ca-app-pub-8624410529269642~5475203631");





    Provider.of<Prodcuts_Provider>(context, listen: false).getlatest();
    Provider.of<Prodcuts_Provider>(context, listen: false).getoffers();

// books.sort((b,a)=>a.price.compareTo(b.price));
    Timer(Duration(microseconds: 300), () {
      setState(() {
        welcomeStyle = GoogleFonts.lato(
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(57, 50, 50, 1),
          fontSize: 25,
        );
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    clicked=Provider.of<Prodcuts_Provider>(context).clicked;
    latestproducts = Provider
        .of<Prodcuts_Provider>(context)
        .latestproducts;
    offers = Provider
        .of<Prodcuts_Provider>(context)
        .offers;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: Text(botindex == 0 ? "Amanda Makeup" :botindex == 1 ? "Our Products":botindex==2? "Tips":"Virtual Makeup"),actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(child: Icon(FontAwesomeIcons.facebook,size: 30,),onTap: (){launch("https://www.facebook.com/Amanda-Makeup-107748704816734",forceSafariVC: false);}),
      )],),
      body: latestproducts == null || offers == null
          ? Center(child: net==false?Container(
        height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children:[ Text("Check Internet",style: TextStyle(fontSize: 20)),
            Icon(Icons.clear,color: Colors.red,size: 32,)]),
          ): CircularProgressIndicator())
          : botindex == 0
          ? Main_Category():botindex==1? SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 20,
              ),

              Container(

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/6cd61821-a978-40fd-8766-2adeee0d5581.jfif',
                    fit: BoxFit.cover,
                  ),
                ),),


              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              Explore(
                                view: "offers",
                              ))),
                  child: SkeletonAnimation(


                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 1),
                        child: Text(
                          "Offers",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...offers
                        .map(
                          (e) =>
                      offers.indexOf(e) ==
                          offers.length - 1
                          ? InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    Explore(
                                      view: "offers",
                                    ))),
                        child: Column(
                          children: [
                            CircleAvatar(
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  size: 30,
                                )),
                            Text("See more")
                          ],
                        ),
                      )
                          : InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Details(e)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Stack(
                            children: [
                              Container(
                                width: 200,
                                height: 295,
                                child: Card(
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 200,
                                            width: 150,
                                            child: Image.network(
                                              "http://amanda-makeup.com/images/${e
                                                  .image}",
                                              fit: BoxFit.cover,
                                            )),
                                        Text(e.name,
                                          style: GoogleFonts.exo(
                                              fontWeight:
                                              FontWeight
                                                  .bold),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,),
                                        Text(
                                          "${(e.price -
                                              (e.price * e.offer / 100))
                                              .round()
                                              .toString()} L.E",
                                          style: GoogleFonts.exo(fontSize: 17),
                                        ),
                                        Text(
                                          "${e.price.toString()} L.E",
                                          style: GoogleFonts.exo(
                                              decoration:
                                              TextDecoration
                                                  .lineThrough,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    )),
                              ),
                              Positioned(
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
                         e.color_code==null?Container():     Banner(
                                color: Color.fromRGBO(int.parse(e.color_code.substring(0,3)),int.parse(e.color_code.substring(4,7)),int.parse(e.color_code.substring(8,11)),1),
                                location:
                                BannerLocation.topStart,
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
                      ),
                    )
                        .toList()
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              Explore(
                                view: "latest",
                              ))),
                  child: SkeletonAnimation(

                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 1),
                        child: Text(
                          "Latest Prodcuts",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...latestproducts
                        .map((e) =>
                    latestproducts.indexOf(e) ==
                        latestproducts.length - 1
                        ? InkWell(
                      onTap: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  Explore(
                                    view: "latest",
                                  ))),
                      child: Column(
                        children: [
                          CircleAvatar(
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                size: 30,
                              )),
                          Text("See more")
                        ],
                      ),
                    )
                        : InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => Details(e)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Card(
                                child: Container(
                                  width: 200,
                                  height: 295,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 200,
                                          width: 150,
                                          child: Image.network(
                                            "http://amanda-makeup.com/images/${e
                                                .image}",
                                            fit: BoxFit.cover,
                                          )),
                                      Text(e.name,
                                        style: GoogleFonts.exo(
                                            fontWeight:
                                            FontWeight
                                                .bold),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,),

                                      Text(
                                        e.offer == 0
                                            ? "${e.price.toString()} L.E"
                                            : " ${(e.price -
                                            (e.price * e.offer / 100))
                                            .round()
                                            .toString()} L.E",
                                        style: GoogleFonts.exo(fontSize: 17),
                                        textAlign:
                                        TextAlign.center,
                                      ),
                                      e.offer == 0
                                          ? Container()
                                          : Text(
                                        "${e.price.toString()} L.E",
                                        style: GoogleFonts.exo(
                                            decoration:
                                            TextDecoration
                                                .lineThrough,
                                            color: Colors
                                                .grey),
                                      ),
                                    ],
                                  ),
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
                        e.color_code==null?Container():    Banner(
                              color: Color.fromRGBO(int.parse(e.color_code.substring(0,3)),int.parse(e.color_code.substring(4,7)),int.parse(e.color_code.substring(8,11)),1),
                              location:
                              BannerLocation.topStart,
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
                        .toList()
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Card(
                  color: Colors.redAccent,
                  child:
                  FlatButton(

                    onPressed: () {
                      launch(

                          "https://www.jumia.com.eg/ar/customer/order/index/"
                     );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Trace Orders", style: TextStyle(color: Colors.white,
                            fontSize: 19),),
                        Icon(Icons.shopping_cart, color: Colors.grey[300],
                          size: 27,)
                      ],
                    ),),


                ),
              ),
              Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.info_outline),
                  SizedBox(width: 5,),
                  Text("trace your preodered products")
                ],
              ),
            ]),
      )

         :botindex==2? Tips():Makeup(),

      bottomNavigationBar: BottomNavigationBar(

        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromRGBO(67, 85, 96, 1),
        onTap: (index) {
          clicked==false? playad():null;
          Provider.of<Prodcuts_Provider>(context,listen: false).click();
          setState(() {
            botindex = index;
          });
        },
        selectedItemColor: Colors.orangeAccent,
        currentIndex: botindex,
        items: [
          BottomNavigationBarItem(

              icon: Icon(
                Icons.home,

              ),
              label: "Home",
        backgroundColor: Color.fromRGBO(67, 85, 96, 1)),


          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_activity,
              ),
              label: "Products",
              backgroundColor: Color.fromRGBO(67, 85, 96, 1)),
          BottomNavigationBarItem(

              icon: Icon(
                Icons.collections_bookmark,
              ),
              label: "Tips",
              backgroundColor: Color.fromRGBO(67, 85, 96, 1)
          ),  BottomNavigationBarItem(

              icon: Icon(
                Icons.face_unlock_rounded,
              ),
              label: "Try Makeup",
              backgroundColor: Color.fromRGBO(67, 85, 96, 1)
          ),



        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
