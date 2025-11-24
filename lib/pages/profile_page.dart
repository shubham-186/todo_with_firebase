import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_with_firebase/auth/login.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor:Colors.white,
        appBar:AppBar(
          centerTitle: false,
          foregroundColor:Colors.black,
          backgroundColor: Colors.white,
          title: Text("Profile",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          actions: [
            GestureDetector(
              onTap: (){
                print("edit profile");
              },
              child: Image.asset("assets/images/edit.png",
                height: 20,
                width: 20,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12,)
          ],
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/person.png",)),
                        shape: BoxShape.circle,
                        color: Colors.grey.shade400,
                        // border: Border.all(
                        //     color: Colors.pink,
                        //     width: 3
                        // )
                    ),
                  ),
                  SizedBox(height: 5,),
                  // GestureDetector(
                  //   onTap: ()async{
                  //     XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                  //     if(pickedImage != null){
                  //       CroppedFile? croppedImg = await ImageCropper().cropImage(sourcePath: pickedImage.path,uiSettings: [
                  //         AndroidUiSettings(
                  //           lockAspectRatio: true,
                  //           initAspectRatio: CropAspectRatioPreset.square,
                  //         ),
                  //         IOSUiSettings()
                  //       ]);
                  //       if(croppedImg != null){
                  //         selectedImage = File(croppedImg.path);
                  //         _saveImagePath(croppedImg.path);
                  //         setState(() {});
                  //       }
                  //     }
                  //   },
                  //   child:Text("Edit",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.pink),),
                  // ),
                  SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 72),
                    child: Container(
                      width: double.infinity,
                      height: 0.2,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade200,
                              width: 1
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 1
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.account_circle,size: 20,),
                            SizedBox(width: 7,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",style: TextStyle(fontWeight: FontWeight.w500),),
                                Text("Shubham",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                              ],
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_forward_ios,size: 15,color: Colors.pink,),
                            SizedBox(width: 7,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 1
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.phone,size: 20,),
                            SizedBox(width: 7,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone",style: TextStyle(fontWeight: FontWeight.w500),),
                                Text("9478743382",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                              ],
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_forward_ios,size: 15,color: Colors.pink,),
                            SizedBox(width: 7,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 1
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.pin_drop_rounded,size: 20,),
                            SizedBox(width: 7,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address",style: TextStyle(fontWeight: FontWeight.w500),),
                                Text("ludhiana, Punjab",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                              ],
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_forward_ios,size: 15,color: Colors.pink,),
                            SizedBox(width: 7,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 1
                            )
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.notification_add_rounded,size: 20,color: Colors.blue,),
                            SizedBox(width: 7,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Notification",style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_forward_ios,size: 15,color: Colors.pink,),
                            SizedBox(width: 7,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 1
                            )
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/theme.png',height: 18,width: 18,),
                            SizedBox(width: 7,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Theme",style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_forward_ios,size: 15,color: Colors.pink,),
                            SizedBox(width: 7,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 1
                            )
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/language.png',height: 18,width: 18,),
                            SizedBox(width: 7,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Language",style: TextStyle(fontWeight: FontWeight.w500),),
                              ],
                            ),
                            Spacer(),
                            // Icon(Icons.arrow_forward_ios,size: 15,color: Colors.pink,),
                            SizedBox(width: 7,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: (){
                      logoutDialogBox(context);
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: 1
                              )
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/logout.png',height: 25,width: 25,color: Colors.red,),
                              SizedBox(width: 7,),
                              Text("Logout",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red),),
                              Spacer(),
                              Container(
                                height: 28.5,
                                width: 28.5,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border: Border.all(
                                        width: 1, color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Icon(Icons.arrow_forward_ios,size: 15,color: Colors.blue,),
                              ),
                              // Icon(Icons.arrow_forward_ios,size: 15,color: Colors.blue,),
                              SizedBox(width: 7,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  /*Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: 1
                          )
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.headphones,size: 20,),
                          SizedBox(width: 7,),
                          Text("Costumer & Support",style: TextStyle(fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,size: 15,color: Colors.pink,),
                          SizedBox(width: 7,)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: 1
                          )
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.logout,size: 20,),
                          SizedBox(width: 7,),
                          Text("Logout",style: TextStyle(fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,size: 15,color: Colors.pink,),
                          SizedBox(width: 7,)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8,),*/
                ],
              ),
            ),
          ),
        )
    );
  }
}

void logoutDialogBox(BuildContext context,) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // Rounded corners ko kam rakha
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),

        // Background Color White
        backgroundColor: Colors.white,

        // 1. Title Padding ko aur kam kiya (Top: 15, Bottom: 0)
        titlePadding: const EdgeInsets.fromLTRB(24, 15, 24, 0),

        // 2. Content Padding ko aur kam kiya (Top: 5, Bottom: 10)
        contentPadding: const EdgeInsets.fromLTRB(24, 5, 24, 10), // <--- CHANGE HERE

        title: const Text(
          'Logout?',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600, // Thoda bold rakha
            fontSize: 17, // 3. Font Size ko 18 se 17 kiya
          ),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            color: Colors.black54, // Color halka dark gray
            fontWeight: FontWeight.w400,
            fontSize: 13, // Font Size ko 14 se 13 kiya
          ),
        ),

        // Actions (Buttons)
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          // 'Yes' Button
          Container(
            height: 35, // Button ki height 37 se 35 ki
            width: 105, // Width halki kam ki
            decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(6) // Radius halka kam kiya
            ),
            child: TextButton(
              onPressed: () async{

                SharedPreferences getShared = await SharedPreferences.getInstance();
                getShared.remove('user_id');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
                  return LoginPage();
                }));
              },
              child: const Text('Yes',style: TextStyle(color: Colors.white, fontSize: 13),), // Font Size kam kiya
            ),
          ),

          // 'No' Button
          Container(
            height: 35, // Button ki height 37 se 35 ki
            width: 105, // Width halki kam ki
            decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(6) // Radius halka kam kiya
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No',style: TextStyle(color: Colors.white, fontSize: 13),), // Font Size kam kiya
            ),
          ),
        ],
      );
    },
  );
}