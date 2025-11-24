import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_with_firebase/auth/sign_up.dart';
import 'package:todo_with_firebase/pages/Homepage_test.dart';
import 'package:todo_with_firebase/pages/homepage.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FirebaseAuth? auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          // Blue curved header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          // White login section
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(200),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Email, Password, Buttons etc.
                    SizedBox(height: 40,),
                    // Image.asset("assets/images/Gemini_Generated_Image_46apci46apci46ap.png",width:215,height: 215,),
                    Image.asset("assets/images/test.png",width:200,height: 200,fit: BoxFit.fill,),
                    SizedBox(height: 30,),
                    TextField(
                      controller: emailController,
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.account_circle_sharp,color: Colors.blue,),
                        // label: Text("Email",style: TextStyle(color: Colors.blue),),
                          label: Text("Username",style: TextStyle(fontSize: 12),),
                        hintText: "Username",
                        hintStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),

                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(61)
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(61)
                        )
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: passController,
                      obscureText: false,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock,color: Colors.blue,),
                          label: Text("Password",style: TextStyle(fontSize: 12),),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(61)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(61)
                          )
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text("Forget Password",style:
                          TextStyle(color: Colors.black54,
                            fontSize: 10,
                            fontFamily: "semiBold"
                          ),),
                        )
                      ],
                    ),
                    SizedBox(height: 22.5,),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        elevation: 4,
                        child: OutlinedButton(
                          onPressed: () async {
                            ///loginUser
                            try{
                              var userCred = await auth!.signInWithEmailAndPassword(email: emailController.text,
                                  password: passController.text);
                              if(userCred.user != null){
                                ScaffoldMessenger.of(context).
                                showSnackBar(SnackBar(content: Text('Successfully Login'),backgroundColor: Colors.green.shade300,));
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("user_id",userCred.user!.uid);
                                print("generated UserID:");
                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('UserID is: ${userCred.user}'),backgroundColor: Colors.green,));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
                                  return Homepage();
                                }));
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('UserID is: ${userCred.user}'),backgroundColor: Colors.red,));
                              }
                            }on FirebaseAuthException catch(e){
                              print("Firebase Auth Error: ${e.code}");
                            }
                            catch(e){
                            };
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white.withOpacity(0.12), // White splash effect
                            side: BorderSide(color: Colors.blue), // Border color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(81), // Same border radius as text fields
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12), // Height ko kam karne ke liye padding kam ki
                          ),
                          child: Text(
                            "Sign-in",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("or continue with",style: TextStyle(fontSize: 12.2,color: Colors.black),),
                    SizedBox(height: 19),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 135,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black
                            ),
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("assets/images/google.png",width: 22,height: 22,),
                              Text("Google",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        Container(
                          width: 135,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(24)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("assets/images/apple_1.png",width: 22,height: 22,),
                              Text("Apple",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ",style: TextStyle(color: Colors.grey),),
                          Text("Sign-up", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,decoration: TextDecoration.underline,decorationColor: Colors.blue),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // AppBar-style Login text in center
          /*Positioned(
            top: 45,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/back.png"),
                        ),
                      ),
                    ),
                ),
                // Image.asset("assets/images/lock.png", width: 30, height: 30,),
              ],
            ),
          )*/
        ],
      ),
    );

  }
}
