import 'package:Makeup_app/categories.dart';
import 'package:Makeup_app/prodcuts_provider.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'Explore.dart';

class Main_Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Main_Category_State();
  }
}

class Main_Category_State extends State<Main_Category> {
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    clicked=Provider.of<Prodcuts_Provider>(context).clicked;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GridView.count(
          childAspectRatio: 3.8 / 4,
          crossAxisCount: 2,
          children: [
          InkWell(

          onTap: ()
      { clicked==false? playad():null;
      Provider.of<Prodcuts_Provider>(context,listen: false).click();
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Categories(category: "face",)));},
      splashColor: Colors.redAccent,

      child: Card(
          elevation: 5,
          child: Stack(

            children: [


                   Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.asset(
                      "assets/images/f05c3228d6fdcea45ed4f977a95e8737.jpg",
                      fit: BoxFit.fill,
                    ),




              ),
              Positioned(bottom: 10,left: 10,child: SkeletonAnimation(child: Text("Face", style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)))
            ],
          )),


    ),
            InkWell(
              onTap: ()
              {
                clicked==false? playad():null;
                Provider.of<Prodcuts_Provider>(context,listen: false).click();

                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Categories(category: "lips",)));},
              splashColor: Colors.redAccent,

              child: Card(
                  elevation: 5,
                  child: Stack(

                    children: [
                      Container(
                        height:double.infinity,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/images (7).jfif",
                          fit: BoxFit.fill,
                        ),

                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      ),
                      Positioned(bottom: 10,left: 10,child: SkeletonAnimation(child: Text("Lips", style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)))
                    ],
                  )),


            ),
            InkWell(
              onTap: ()
              { clicked==false? playad():null;
              Provider.of<Prodcuts_Provider>(context,listen: false).click();Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Categories(category: "eyes",)));},
              splashColor: Colors.redAccent,

              child: Card(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/183226371_208817520815438_1684293695066852711_n.jpg",
                          fit: BoxFit.fill,
                        ),

                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      ),
                      Positioned(bottom: 10,left: 10,child: SkeletonAnimation(child: Text("Eyes", style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)))
                    ],
                  )),


            ),
            InkWell(
              onTap: ()
              {clicked==false? playad():null;
              Provider.of<Prodcuts_Provider>(context,listen: false).click(); Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Categories(category: "nails",)));},
              splashColor: Colors.redAccent,

              child: Card(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/182690840_226007945951516_3935820885899441738_n.jpg",
                          fit: BoxFit.fill,
                        ),

                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      ),
                      Positioned(bottom: 10,left: 10,child: SkeletonAnimation(child: Text("Nails", style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)))
                    ],
                  )),


            ),
            InkWell(
              onTap: ()
              { clicked==false? playad():null;
              Provider.of<Prodcuts_Provider>(context,listen: false).click();Provider.of<Prodcuts_Provider>(context,listen: false).nullproduct(); Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Explore(category:"/hair",)));},
              splashColor: Colors.redAccent,

              child: Card(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/download (13).jpg",
                          fit: BoxFit.fill,
                        ),

                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      ),
                      Positioned(bottom: 10,left: 10,child: SkeletonAnimation(child: Text("Hair", style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)))
                    ],
                  )),


            ),
            InkWell(
              onTap: ()
              { clicked==false? playad():null;
              Provider.of<Prodcuts_Provider>(context,listen: false).click();Provider.of<Prodcuts_Provider>(context,listen: false).nullproduct(); Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Explore(category:"/skincare",)));},
              splashColor: Colors.redAccent,

              child: Card(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/download (12).jpg",
                          fit: BoxFit.fill,
                        ),

                        decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      ),
                      Positioned(bottom: 10,left: 10,child: SkeletonAnimation(child: Text("Skin Care", style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)))
                    ],
                  )),


            ),


  ]

    ));
  }
}