
import 'dart:async';

import 'package:Makeup_app/main.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage())));
   return Scaffold(
     body:Container(
       width: double.infinity,
       height: MediaQuery.of(context).size.height,
    color: Colors.white,
       child: Center(child: Image.asset("assets/images/240_F_207664499_nM5qZ8CKHoUKSJuYcntFuBATa0eccvEG.jpg",fit: BoxFit.cover,)),
     )
   );
  }

}