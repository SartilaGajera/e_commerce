import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email='';
  @override
  void initState() {
    customData();
    super.initState();
  }

  customData()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    email=pref.getString('email')??"";
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height / 4,
            color: Colors.white,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CircleAvatar(
                  backgroundColor: const Color(0xff800000),
                  maxRadius: 40,
                  minRadius: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(email!=''?
                      email[0].toUpperCase():"",
                      style: const TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 5),
                Text(email??"", style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const Divider(height: 0, thickness: 2),
          Expanded(
              child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              customProfileCard(text: 'Edit Profile'),
              const Divider(height: 0, thickness: 2),
              customProfileCard(text: 'Change Password'),
              const Divider(height: 0, thickness: 2),
              customProfileCard(text: 'Customer Care'),
              const Divider(height: 0, thickness: 2),
              customProfileCard(text: 'How To Return'),
              const Divider(height: 0, thickness: 2),
              customProfileCard(text: 'Terms & Conditions'),
              const Divider(height: 0, thickness: 2),
              customProfileCard(text: 'Return Policy'),
              const Divider(height: 0, thickness: 2),
              customProfileCard(text: 'Refund Policy'),
              const Divider(height: 0, thickness: 2),
              customProfileCard(text: 'Join Our Team'),
              const Divider(height: 0, thickness: 2),
            ],
          )),
        ],
      ),
    );
  }

  Widget customProfileCard({String? text}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 70,
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Text(
              text!,
              style: const TextStyle(color: Color(0xff800000), fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
