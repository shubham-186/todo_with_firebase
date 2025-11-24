import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_with_firebase/firestore_repo/firestore_repository.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passConroller = TextEditingController();
  TextEditingController phoneControler = TextEditingController();

  // You don't need the _formKey or FormState anymore

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Stack(
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

            // White Sign up section
            Positioned(
              top: 130,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column( // Removed Form widget
                    children: [
                      SizedBox(height: 5,),
                      // Icon(Icons.assignment_turned_in, size: 50, color: Colors.blue,),
                      Icon(Icons.person_add , size:100, color: Colors.blue,),
                      SizedBox(height: 25,),
                      // --- Name Field ---
                      TextFormField(
                        controller: nameController,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.account_circle_sharp, color: Colors.blue,),
                            label: Text("Name", style: TextStyle(fontSize: 12),),
                            hintText: "Name",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(61)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(61)
                            )
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Name cannot be empty'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20,),
                      // --- Email Field ---
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email_outlined, color: Colors.blue,),
                            label: Text("Email", style: TextStyle(fontSize: 12),),
                            hintText: "Email",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(61)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(61)
                            )
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Email cannot be empty'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20,),
                      // --- Phone Field ---
                      TextFormField(
                        controller: phoneControler,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.phone, color: Colors.blue,),
                            label: Text("Phone", style: TextStyle(fontSize: 12),),
                            hintText: "Phone",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(61)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(61)
                            )
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Phone number cannot be empty'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20,),
                      // --- Password Field ---
                      TextFormField(
                        controller: passConroller,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.lock, color: Colors.blue,),
                            label: Text("Password", style: TextStyle(fontSize: 12),),
                            hintText: "Password",
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(61)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(61)
                            )
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Password cannot be empty'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10,
                                  fontFamily: "semiBold"
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30,),
                      // --- Register Button ---
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          elevation: 4,
                          child: OutlinedButton(
                            onPressed: () async{
                              if (nameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  phoneControler.text.isEmpty ||
                                  passConroller.text.isEmpty) {
                               /* ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please fill all the fields to register.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );*/
                              }else if(passConroller.text.length<8){
                                /*ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password must be at least 8 characters long'),
                                    backgroundColor: Colors.red,
                                  ),
                                );*/
                              }
                              else {
                                try{
                                  FirestoreRepository.signUp(
                                      name: nameController.text,
                                      password: passConroller.text,
                                      email: emailController.text,
                                      phone: phoneControler.text
                                  );
                                  SharedPreferences sp = await SharedPreferences.getInstance();
                                  sp.setString('pass', passConroller.text);
                                  Navigator.pop(context);
                                }catch(e){
                                }
                                // Your registration logic goes here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Successfully Signed in..'),backgroundColor: Colors.green,),
                                );
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              // foregroundColor: Colors.white,
                              foregroundColor: Colors.white.withOpacity(0.12), // White splash effect
                              side: BorderSide(color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(81),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ", style: TextStyle(color: Colors.grey),),
                          Text("Sign In", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,decoration: TextDecoration.underline,decorationColor: Colors.blue),),
                          // Text("See all",style: TextStyle(color: Colors.pink.shade500,decoration: TextDecoration.underline,decorationColor: Colors.pink ),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Back Arrow and Register text
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.8,
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,size: 16,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}