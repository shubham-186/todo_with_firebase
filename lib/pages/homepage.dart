import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_with_firebase/firestore_repo/firestore_repository.dart';
import 'package:todo_with_firebase/pages/profile_page.dart';
import 'package:todo_with_firebase/pages/task_info_page.dart';
import '../app_widgets/outlined_custom_btn.dart';
import '../model/todo_model.dart';

enum TodoFilter { all, notCompleted, isCompleted }

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Homepage_state();
  }
}

class Homepage_state extends State<Homepage> {

  FirebaseFirestore? firestore;
  CollectionReference? collectionRef;
  TextEditingController titleControler = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  // Ab in variables ki zaroorat nahi hai kyunki filtering StreamBuilder ke andar hogi.
  // List<TodoModel> todoList = [];
  // List<TodoModel> displayedTodoList = [];
  // List<TodoModel> tempFilteredList = [];

  TodoFilter currentFilter = TodoFilter.all;
  List<String> priorityList = ["High", "Medium", "Low"];
  String selectedPriority = "";
  int selectPriority_pos = 0;
  String? user_id;

  @override
  void initState() {
    super.initState();
    getUserID();
    // ❌ _applyFiltersToDisplayedList(); aur setState ko yahan se hata diya gaya hai.
    // Filtering ab searchController listener ya filter button press par sirf build ko trigger karegi.
    searchController.addListener(_onSearchChange);
  }

  // ⚠️ Old filtering function (jismein setState tha) ko remove/replace kar diya gaya hai.
  // Ab filtering StreamBuilder ke andar hoti hai.

  @override
  void dispose() {
    searchController.removeListener(_onSearchChange);
    searchController.dispose();
    titleControler.dispose();
    descController.dispose();
    super.dispose();
  }

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    firestore = FirebaseFirestore.instance;
    // collectionRef ko initialize karte hi setState call karna zaroori hai taki StreamBuilder run ho sake
    collectionRef = firestore!
        .collection(FirestoreRepository.userDetails)
        .doc(user_id)
        .collection(FirestoreRepository.collectionToDos);
    setState(() {});
  }

  // Ab yeh function sirf setState call karega taaki build() method dobara chale aur StreamBuilder ke andar search logic apply ho.
  _onSearchChange() {
    setState(() {
      // searchController.text ki value change hone par state update hoga.
    });
  }
  // Yeh logic StreamBuilder ke andar data aane ke baad filtering karegi.


  List<TodoModel> _getFilteredList(List<TodoModel> originalList) {

    List<TodoModel> filteredList = List.from(originalList);
    String currentSearchText = searchController.text.toLowerCase();

    // 1. Search Filtering
    if (currentSearchText.isNotEmpty) {
      filteredList = filteredList.where((todos) {
        return todos.title.toLowerCase().contains(currentSearchText) ||
            todos.desc.toLowerCase().contains(currentSearchText);
      }).toList();
    }

    // 2. Status Filtering
    if (currentFilter == TodoFilter.isCompleted) {
      filteredList = filteredList.where((todos) {
        return todos.isCompleted == true;
      }).toList();
    } else if (currentFilter == TodoFilter.notCompleted) {
      filteredList = filteredList.where((todos) {
        return todos.isCompleted == false;
      }).toList();
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(26),
                      bottomLeft: Radius.circular(26))),
              elevation: 4,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                height: 133,
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/edit.png',
                              height: 15,
                              width: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "T̾a̾s̾k̾",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "F̾l̾o̾w̾",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue.shade600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(25)),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (ctx) {
                                          return ProfilePage();
                                        }));
                                  },
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.blue.shade600,
                                    size: 24,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 288,
                          height: 43,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                              fillColor: Colors.grey,
                              contentPadding: EdgeInsets.all(5),
                              hintText: "Search your to-do...",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        GestureDetector(
                          onTap: (){
                            print('Filter Tapped');
                            showModalBottomSheet(isDismissible: true,context: context, builder: (ctx_,){
                              return Container(
                                height: 230,
                                width: double.infinity,
                                child: Column(
                                  // Buttons ko beech mein laane ke liye
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 7,),
                                    Container(
                                      height: 5,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.shade600
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 15,),
                                        Text('Filtered By',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                        SizedBox(width: 2,),
                                        Icon(Icons.tune),
                                        Spacer(),
                                        // IconButton(onPressed: (){}, icon: Icon(Icons.cancel,),padding: EdgeInsets.zero,),
                                        InkWell(
                                          onTap: (){
                                            print('close Pressed');
                                            Navigator.pop(context);
                                          },
                                            child: Icon(Icons.cancel,size: 28,color: Colors.blue.shade800,)),
                                        SizedBox(width: 15,),
                                        // Icon(Icons.cancel)
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      width: 380,
                                      height: 0.7,
                                      // padding: EdgeInsets.symmetric(horizontal: 12),
                                      color: Colors.grey
                                    ),
                                    Spacer(),
                                    // 1. Not Completed Todos
                                    _buildFilterButton(
                                        title: 'All Todos',
                                        filterType: TodoFilter.all
                                    ),
                                    // 2. Completed Todos
                                    _buildFilterButton(
                                        title: 'Completed Todos',
                                        filterType: TodoFilter.isCompleted
                                    ),
                                    // 3.Not Completed Todos
                                    _buildFilterButton(
                                        title: 'Not Completed Todos',
                                        filterType: TodoFilter.notCompleted
                                    ),
                                  ],
                                ),
                              );
                            });
                          },

                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            child: Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/filter.png",
                                  height: 18,
                                  width: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 7,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              height: 35,
              width: double.infinity,
              // decoration: BoxDecoration(
              //     border: Border.all(width: 1,color: Colors.black)
              // ),
              child: Row(
                children: [
                Text('Priority:',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(width:6,),
                  SizedBox(
                    height: 30,
                    width: 270,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black)
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('High',style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.red,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Medium',style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.blue,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Low',style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 3,),
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            // SizedBox(height: 7,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: collectionRef != null
                    ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: collectionRef!.snapshots()
                    as Stream<QuerySnapshot<Map<String, dynamic>>>?,
                    builder: (__, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snap.hasError) {
                        return Center(
                          child: Text("${snap.error}"),
                        );
                      }
                      if (snap.hasData) {
                        // 1. Live Firestore data ko TodoModel objects mein convert karein
                        List<TodoModel> liveTodoList = [];
                        for (QueryDocumentSnapshot<Map<String, dynamic>>
                        eachDocs in snap.data!.docs) {
                          liveTodoList.add(TodoModel.fromDoc(eachDocs));
                        }

                        // 2. Filtering aur Searching logic apply karein (NO setState here!)
                        List<TodoModel> finalDisplayedList = _getFilteredList(liveTodoList);

                        return finalDisplayedList.isNotEmpty
                            ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: finalDisplayedList.length,
                            itemBuilder: (_, index) {
                              var list = finalDisplayedList[index];

                              var dFormate = DateFormat.yMMMMEEEEd();
                              var assignedAt = dFormate.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(list.assignedAt)));
                              var completedAt = list.completedAt != ""
                                  ? dFormate.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(list.completedAt)))
                                  : "";
                              return Card(
                                color: getBackgroundColor(list.priority),
                                elevation: 8,
                                child: Column(
                                  children: [
                                    CheckboxListTile(
                                      side: BorderSide(color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      value: list.isCompleted,
                                      onChanged: (value) {
                                        FirestoreRepository.markedTodos(
                                            user_id: user_id!,
                                            user_doc_id: list.todoID!,
                                            status: value!);
                                        print('Status: $value');
                                      },
                                      title: Text(
                                        list.title,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            decoration: list.isCompleted
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),

                                        // 💡 CHANGES FOR ELLIPSIS ON TITLE
                                        maxLines: 1, // Title ko sirf 1 line tak hi dikhao
                                        overflow: TextOverflow.ellipsis, // Agar 1 line se bada ho, toh ... laga do
                                      ),
                                      subtitle: Text(
                                        list.desc,
                                        style: TextStyle(
                                            color: Colors.white,
                                            decoration: list.isCompleted
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                        // 💡 Naya Code: Yahan text wrap hone ki jagah ... aa jayega
                                        maxLines: 1, // Maximum 2 lines tak dikhega
                                        overflow: TextOverflow.ellipsis, // Jab text overflow hoga, tab ... dikhega
                                      ),
                                    ),
                                    /*Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "Assigned At:",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                        Text(
                                          assignedAt,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                      ],
                                    ),*/   /// Assigned Date
                                    /*Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "Completed At:",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                        Text(
                                          completedAt,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                      ],
                                    ),*/   /// Completed Date
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  // Update ke liye bottom sheet
                                                  titleControler.text = list.title;
                                                  descController.text = list.desc;
                                                  selectPriority_pos = list.priority;
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (ctx) {
                                                        return bottomSheetContent(
                                                            isUpdate: true,
                                                            user_id: user_id!,
                                                            user_doc_id:
                                                            list.todoID!);
                                                      });
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  if (list.todoID != null) {
                                                    FirestoreRepository
                                                        .deleteTodos(
                                                        user_id:
                                                        user_id!,
                                                        doc_id:
                                                        list.todoID!);
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Todo Deleted Successfully"),
                                                      backgroundColor:
                                                      Colors.green,
                                                    ));
                                                    print(
                                                        'Your Deleted ID: ${list.todoID}');
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "ID not found to Delete"),
                                                      backgroundColor:
                                                      Colors.red,
                                                    ));
                                                    print(
                                                        'Your Deleted ID: ${list.todoID}');
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                              return TaskInfoPage(
                                                  title: list.title,
                                                  desc: list.desc,
                                                  assignedDate: list.assignedAt,
                                                  completedDate: list.completedAt,
                                                  status: list.isCompleted,
                                                  priority: list.priority,
                                                  // selectedIndex: selectPriority_pos,
                                              );
                                            }));
                                          },
                                          child: Row(
                                            children: [
                                              Text('Task Details',style: TextStyle(color: Colors.white),),
                                              Icon(Icons.double_arrow,color: Colors.white,size: 20,),
                                              SizedBox(width:7,)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 2)
                                  ],
                                ),
                              );
                            })
                            : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Data",
                                style: TextStyle(
                                    color: Colors.grey.shade400),
                              ),
                              Image.asset(
                                "assets/images/todo_icon.png",
                                height: 50,
                                width: 50,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    })
                    : Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleControler.clear();
          descController.clear();
          selectPriority_pos = 0;
          showModalBottomSheet(context: context, builder: (context) {
            return bottomSheetContent(isUpdate: false);
          });
        },
        splashColor: Colors.blue,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.list_alt,
        ),
      ),
    );
  }

  // bottomSheetContent method aur getBackgroundColor method mein koi changes nahi kiye gaye hain.

  Widget bottomSheetContent({bool isUpdate = false, String user_id = "", String user_doc_id = ""}) {
    return Padding(
      // Padding ka istemaal karein
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        // SingleChildScrollView se wrap karein
        child: Column(
          mainAxisSize: MainAxisSize.min, // Yeh property add karein
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.navigate_before, color: Colors.blue)),
                Text(isUpdate?"Update ToDo's":"Add ToDo's",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.blue)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              width: 600,
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 18,
            ),
            TextField(
              controller: titleControler,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                label: Text(
                  "Title",
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
                hintText: "Title",
                hintStyle:
                TextStyle(fontSize: 12, color: Colors.grey.shade400),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
            SizedBox(
              height: 9,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                label: Text(
                  "Desc",
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
                hintText: "description",
                hintStyle:
                TextStyle(fontSize: 12, color: Colors.grey.shade400),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
            SizedBox(
              height: 13,
            ),
            DropdownMenu(
                width: MediaQuery.of(context).size.width - 22,
                textStyle: TextStyle(fontSize: 12),
                // Update ke time sahi priority dikhane ke liye initial value set ki
                initialSelection: priorityList[selectPriority_pos],
                selectedTrailingIcon: Icon(Icons.low_priority_rounded),
                trailingIcon: Icon(
                  Icons.arrow_drop_down_circle_sharp,
                  color: Colors.blue,
                  size: 28,
                ),
                label: Text(
                  "Priority",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                onSelected: (String? priority) {
                  if (priority != null) {
                    selectedPriority = priority;
                    selectPriority_pos =
                        priorityList.indexOf(selectedPriority);
                    print("your selected Priority: $selectedPriority");
                    print("current selected index: $selectPriority_pos");
                  }

                },
                dropdownMenuEntries: priorityList
                    .map((priority) =>
                    DropdownMenuEntry(value: priority, label: priority))
                    .toList()),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedCustomBtn(
                    onPressed: () {

                      if (titleControler.text.isEmpty &&
                          descController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Title/Description is required"),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        if (isUpdate) {
                          FirestoreRepository.updateTodos(
                              user_id: user_id,
                              user_doc_id: user_doc_id,
                              todo_title: titleControler.text,
                              todo_desc: descController.text,
                              priority: selectPriority_pos); // Update priority as well
                          Navigator.pop(context);
                          print('priority: $selectPriority_pos');
                        } else if (user_id != null) {
                          collectionRef!.add(TodoModel(
                              title: titleControler.text.toString(),
                              desc: descController.text.toString(),
                              assignedAt: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              priority: selectPriority_pos)
                              .toDoc());
                          Navigator.pop(context);
                        }
                      }
                      },
                    title: isUpdate ? "Update" : "Add"),
                OutlinedCustomBtn(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: "Cancel"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getBackgroundColor(int priority) {
    if (priority == 0) {
      return Colors.red;
    } else if (priority == 1) {
      return Colors.blue;
    } else if (priority == 2) {
      return Colors.green;
    } else {
      return Colors.red.shade500;
    }
    // return Colors.white;
  }

  Widget _buildFilterButton({required String title, required TodoFilter filterType}) {
    // Check karein ki kya yeh button current active filter hai
    bool isActive = currentFilter == filterType;

    return Padding(
      // Buttons ke beech mein space dene ke liye
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: InkWell(
        onTap: () {
          setState(() {
            currentFilter = filterType; // Filter set kiya
          });
          Navigator.pop(context); // Bottom sheet close kiya
        },
        // Chat Bubble Design
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          decoration: BoxDecoration(
            // Active button ka color (jaisa aapke chat mein dark green tha, yahaan blue.shade700 use kar raha hoon)
            color: isActive ? Colors.blue.shade700 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                // Text color change hoga based on active state
                color: isActive ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}