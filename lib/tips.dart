import 'package:Makeup_app/prodcuts_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Tips extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
 return Tips_State();
  }
}

class Tips_State extends State<Tips>{
  String tip,tiplabel,image;
  bool show=false;

  @override

  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
   tip= Provider.of<Prodcuts_Provider>(context).tips;
    tiplabel= Provider.of<Prodcuts_Provider>(context).tipslabel;

image=Provider.of<Prodcuts_Provider>(context).tips_image;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Prodcuts_Provider>(context,listen: false).gettips();

  }
  @override
  Widget build(BuildContext context) {
  return

    Scaffold(
      body: image==null || tiplabel==null || tip==null? Center(child: CircularProgressIndicator(),):
      Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
Container(
  width: double.infinity,
height: MediaQuery.of(context).size.height/3,
  child: Image.network("http://www.amanda-makeup.com/tips_images/${image}",fit: BoxFit.cover,),),

SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SkeletonAnimation(

                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 1),
                      child: Text(
                        "Tip of the day",
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
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Stack(
                  children: [

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(tiplabel,textAlign: TextAlign.start,
                          style:GoogleFonts.laila(fontSize: 18,fontWeight: FontWeight.bold) ,),
                        ),
                        Text(tip
                            ,style:GoogleFonts.lato(fontSize: 17 ,))
                      ],
                    ),
                    Positioned(top: 0,right: 0,child: SkeletonAnimation(child: Icon(Icons.lightbulb,size: 30,color: Colors.red,)))
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
  
}