import 'dart:async';

import 'package:e_commerce/view/home/home.dart';
import 'package:e_commerce/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String uid='';

  @override
  void initState() {

customInit();
    super.initState();
  }

  customInit()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    if(pref.getString("uid")!=null) {
      uid = pref.getString("uid")!;
    }

    Timer(
      const Duration(seconds: 2),
          () {
        if (uid!= "") {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Home()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
      },
    );
  }

  @override

  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff800000),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("E",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80, color: Colors.white)),
            Text("M",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.white)),
            Text("A",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 80, color: Colors.white)),
            Text("r",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.white)),
            Text("t",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 85, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
