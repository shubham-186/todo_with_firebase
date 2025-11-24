import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_with_firebase/auth/login.dart';
import 'package:todo_with_firebase/pages/homepage.dart';

class SplashPage extends StatefulWidget{
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPreferences? sp;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Homepage()),
      // );
      sp = await SharedPreferences.getInstance();
      String? check = sp?.getString('user_id');
      Widget nextPage = LoginPage();
      if(check != null){
        if(check.isNotEmpty){
          nextPage = Homepage();
        }else{
          nextPage = LoginPage();
        }
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>nextPage));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/check_logo.png",
              height: 200,
              width: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/check_icon.png",
                  color: Colors.black,
                  height: 50,
                  width: 50
                ),
                // Text("Let's Do",style: TextStyle(fontSize: 16,
                //  color: Colors.black,
                //  fontWeight: FontWeight.w700,decoration: TextDecoration.underline,
                //     decorationColor: Colors.black),),
                Text("T̾a̾s̾k̾",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                SizedBox(width: 5,),
                Text("F̾l̾o̾w̾",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.blue),),
              ],
            )
          ],
        ),
      ),
    );
  }
}