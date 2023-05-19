import 'package:e_commerce/view/category/category_list.dart';
import 'package:e_commerce/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../category/category_product_list.dart';
SharedPreferences? pref;
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String email='';
  @override
  void initState() {
customData();    super.initState();
  }
  customData()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    email=pref.getString('email')??"";
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Drawer(


      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
           UserAccountsDrawerHeader(

            decoration: const BoxDecoration(color:Color(0xff800000)),
            arrowColor: const Color(0xff800000) ,
            accountName: Text(email??""),
            accountEmail: const Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(email!=''?
                 email[0].toUpperCase():"",
                  style: const TextStyle(fontSize: 40.0,color:Color(0xff800000) )
              ),
            ),
          ),
          ExpansionTile(
            iconColor: Colors.black,
            collapsedIconColor: Colors.black,

            title: const Text("Categories",style: TextStyle(fontSize: 15,color:Colors.black)),
            leading: const Icon(Icons.category,color: Color(0xff800000),), //add icon
            childrenPadding: const EdgeInsets.only(left:60), //children padding
            children:categories.isNotEmpty? categories.map((e) =>  ListTile(
              title: Text(e.toString().toUpperCase(),style: const TextStyle(fontSize: 12,color: Color(0xff800000))),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CategoryProduct(type: e)));
              },
            ),).toList():[]

          ),



          ListTile(
            leading: const Icon(Icons.account_circle_outlined,color: Color(0xff800000),), title: const Text("User Profile",style: TextStyle(fontSize: 15,color:Colors.black)),
            onTap: () {
              Navigator.pop(context);

            },
          ),
          ListTile(
            leading: const Icon(Icons.logout,color: Color(0xff800000),), title: const Text("Log Out",style: TextStyle(fontSize: 15,color:Colors.black)),
            onTap: () async{
              Navigator.pop(context);
              SharedPreferences pref=await SharedPreferences.getInstance();
              pref.remove('uid');
              pref.remove('email');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
              );            },
          ),
        ],
      ),
    );
  }
}
