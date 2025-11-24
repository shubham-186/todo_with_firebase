import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel{
  String? todoID;
  String title;
  String desc;
  bool isCompleted;
  int priority;
  String assignedAt;
  String completedAt;

  TodoModel({
    this.todoID,
    required this.title,
    required this.desc,
    required this.assignedAt,
    this.completedAt = "",
    this.isCompleted = false,
    this.priority = 0
  });
  factory TodoModel.fromDoc(QueryDocumentSnapshot<Map<String,dynamic>>doc){
    // Yahan DocumentReference ko String ID mein convert kiya ja raha hai
    // var todoIdValue = doc['todoID'];
    // String? finalTodoId;
    // if (todoIdValue is DocumentReference) {
    //   // Agar DocumentReference mila, to uski ID (String) use karein.
    //   finalTodoId = todoIdValue.id;
    // } else if (todoIdValue is String) {
    //   // Agar pehle se hi String hai, to use use karein.
    //   finalTodoId = todoIdValue;
    // }

    return TodoModel(
      todoID: doc.id,
        title:  doc['title'],
        desc:  doc['desc'],
        assignedAt: doc['assignedAt'],
        completedAt: doc['completedAt'],
        isCompleted: doc['isCompleted'] is bool ? doc['isCompleted'] : false,
        priority: doc['priority'] is int ? doc['priority'] : 0,
    );
  }
  Map<String,dynamic>toDoc(){
    return {
      "todoID":"$todoID",
      "title":title,
      "desc":desc,
      "assignedAt":assignedAt,
      "completedAt":completedAt,
      "isCompleted":isCompleted,
      "priority":priority,
    };
  }
}