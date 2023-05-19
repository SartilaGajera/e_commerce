
import 'package:e_commerce/view/home/home.dart';
import 'package:e_commerce/view/widgets/common_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  final formKey = GlobalKey<FormState>();

  static Future<User?> loginEmailPswd(
      {required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth=FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
      user=userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        SnackBar snackBar = const SnackBar(
          content: Text("This email is not registered!"),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    return user;
  }
  bool isVisible = false;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CommonTexField(
                              controller:email,
                              hintText: "Enter email",
                              color: const Color(0xff800000),

                              labelText: "Email",
                              needValidation: true,
                              validationMessage: "Email",
                              isEmailValidator: true,
                              onChange: (v) {
                                formKey.currentState?.save();
                              },)),
                        Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: CommonTexField(
                              controller:password,
                              hintText: "Enter password",
                              color: const Color(0xff800000),
                              labelText: "Password",
                              needValidation: true,
                              validationMessage: "Password",
                              onChange: (v) {
                                formKey.currentState?.save();
                              },
                              visible: true,
                            )
                        ),
                        GestureDetector(
                          onTap: () async{
                            var isValid = formKey.currentState?.validate();
                            formKey.currentState?.save();
                            if (isValid == true) {
                              User? user=await loginEmailPswd(email: email.text, password: password.text, context: context);
                              if(user!=null)
                                  {
                                    SharedPreferences pref=await SharedPreferences.getInstance();
                                   await pref.setString("uid", user!.uid);
                                   await pref.setString("email", user.email!);
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (_) => const Home()));
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                            height: 50,

                            decoration: BoxDecoration(
                                color: const Color(0xff800000), borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
