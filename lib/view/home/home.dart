import 'package:e_commerce/view/cart/cart_list.dart';
import 'package:e_commerce/view/category/category_list.dart';
import 'package:e_commerce/view/product/product_page.dart';
import 'package:e_commerce/view/slider_img/slider_list.dart';
import 'package:e_commerce/view/user/user-profile.dart';
import 'package:e_commerce/view/widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'drawer_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; //New

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Do you want to exit app?'),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes',style: TextStyle(color: Color(0xff800000)),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('No',style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        },
      );
      return shouldPop!;
    },
      child: GestureDetector(onTap: (){
FocusScope.of(context).unfocus();    },
        child: Scaffold(
          appBar: AppBar(backgroundColor: const Color(0xff800000)),
          drawer: const DrawerScreen(),
          body:_selectedIndex == 0 ?Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [  const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CommonTexField(controller: TextEditingController(), hintText: "search", labelText: ""),
              ),
              const SizedBox(height: 5,), Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [

                  SizedBox(height: MediaQuery.of(context).size.height/4,child: const SliderList(),),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                      child: Text("Categories",style: TextStyle(fontSize: 15,color: Color(0xff800000))),
                    ),
                  const SizedBox(height: 70,child: CategoryList(),),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                      child: Text("Products for you",style: TextStyle(fontSize: 20,color: Color(0xff800000))),
                    ),
                    const SizedBox(height: 5,),
                    const ProductPage(),
                ],),
              ),

            ],
          ): _selectedIndex == 2 ?const ProfileScreen() : const CartList(),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            currentIndex: _selectedIndex,
            //New
            onTap: _onItemTapped,
            iconSize: 35,
            backgroundColor: const Color(0xff800000),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


}
