/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_firebase/model/note_model.dart'; // Ensure this path is correct

class StaticData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StaticData_state();
  }
}

class StaticData_state extends State<StaticData> {
  FirebaseFirestore? firestore;
  CollectionReference? collectionRef;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    collectionRef = firestore!.collection("notes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        title: Text("Static todos", style: TextStyle(fontSize: 16)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionRef!.snapshots(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.hasData) {
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (__, index) {
                var firestore_items = snap.data!.docs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text("${firestore_items["title"] ?? "no title"}"),
                  subtitle: Column(
                    children: [
                      Text("${firestore_items["desc"] ?? "no desc"}"),
                      Text("Created At: ${firestore_items['createdAt']??"no data"}")
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          var noteModel = NoteModel.fromNote(firestore_items);
                          noteModel.id = snap.data!.docs[index].id;
                          showAddUpdateBottomSheet(isUpdate: true, note: noteModel);
                        },
                        icon: Icon(Icons.edit, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: () {
                          collectionRef!.doc(snap.data!.docs[index].id).delete();
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          if (snap.hasError) {
            return Center(child: Text("Error: ${snap.error}"));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddUpdateBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddUpdateBottomSheet({bool isUpdate = false, NoteModel? note}) {
    if (isUpdate) {
      titleController.text = note!.title;
      descController.text = note.desc;
    } else {
      titleController.clear();
      descController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        final keyboardHeight = MediaQuery.of(ctx).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 8.0,
            bottom: keyboardHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12),
                Text(isUpdate ? "Update Data" : "Add Data",
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    label: Text("Title"),
                    hintText: "Title",
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    label: Text("Desc"),
                    hintText: "Desc",
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (isUpdate) {
                          await collectionRef!.doc(note!.id).update({
                            "title": titleController.text,
                            "desc": descController.text,
                          });
                        } else {
                          await collectionRef!.add(NoteModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                          ).toNotes());
                        }
                        Navigator.pop(context);
                      },
                      child: Text(isUpdate ? "Update" : "Add"),
                    ),
                    SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}*/
