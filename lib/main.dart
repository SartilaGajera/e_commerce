import 'package:e_commerce/model/product/product_model.dart';
import 'package:e_commerce/view/splash_screen.dart';
import 'package:flutter/material.dart';
List<ProductModel> cartData=[];

void main() {
  runApp(const App());
}

class App extends MaterialApp {
  const App({super.key}) : super(home:const  SplashScreen(), debugShowCheckedModeBanner: false);
}
