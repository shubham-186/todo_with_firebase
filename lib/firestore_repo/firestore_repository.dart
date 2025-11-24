import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_firebase/model/todo_model.dart';

class FirestoreRepository{
 static var mFireStore = FirebaseFirestore.instance;
 static String collectionToDos = "Todos";
 static String userDetails = "UserDetails";
 static FirebaseAuth auth = FirebaseAuth.instance;

 static addTodos(TodoModel todo) async {
   mFireStore.collection(collectionToDos)
       .add(todo.toDoc()).then((value){
         mFireStore.collection(collectionToDos)
             .doc(value.id)
             .update({"todoID":value.id});
   });
 }
 static Stream<QuerySnapshot<Map<String,dynamic>>> fetchTodos(){
   return mFireStore.collection(collectionToDos)
       .snapshots();
 }
 static void markedTodos({
   required String user_id,
   required String user_doc_id,
   required bool status,
 }){
   String currTime = "";
   if(status){
     currTime = DateTime.now().millisecondsSinceEpoch.toString();
   }
   mFireStore.collection(userDetails)
   .doc(user_id)
   .collection(collectionToDos)
       .doc(user_doc_id)
       .update({
        "isCompleted":status,
        "completedAt":currTime
   });
 }
/* static void updateTodos({required String user_id,
   required String todo_title,
   required String todo_desc})async{
  await mFireStore.collection(user_id)
       .doc(collectionToDos)
       .update({
     "title":"$todo_title",
     "desc":"$todo_desc"
   });
 }*/
      static void updateTodos({
    required String user_id, // <--- USER ID ki zarurat hai sub-collection tak pahunchne ke liye
    required String user_doc_id,
    required String todo_title,
    required String todo_desc,
    required int priority
      }) async {
  await mFireStore.collection(userDetails) // UserDetails collection
  .doc(user_id) // Specific User ka Document
  .collection(collectionToDos) // Todos sub-collection
 .doc(user_doc_id) /// Specific Todos Document
  .update({
  "title": todo_title,
  "desc": todo_desc,
    "priority":priority
 });

}
 static void deleteTodos({required String user_id,required String doc_id})async{
   mFireStore.collection(userDetails)
     .doc(user_id)
     .collection(collectionToDos)
     .doc(doc_id)
     .delete();
 }
 static void signUp({
   required String name,
   required String email,
   required String phone,
   required String password
 }) async {
   try {
     var userCred = await auth.createUserWithEmailAndPassword(email: email, password: password);

     if(userCred.user != null){
       mFireStore.collection(userDetails)
           .doc(userCred.user!.uid)
           .set({
         // "uid": userCred.user!.uid,
         "name": name,
         "email": email,
         "phone": phone,
         "createdAt": Timestamp.now(),
       });
       print("User registered in Auth and profile saved in Users collection.");
     }
   } on FirebaseAuthException catch (e) {
     print("Firebase Auth Error: ${e.code}");
     // Show error to the user (e.g., 'email-already-in-use')
   } catch (e) {
     print("General Error during sign up: $e");
   }
 }
}