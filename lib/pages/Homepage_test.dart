import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskInfoPage extends StatefulWidget {
  final String title;
  final String desc;
  final String assignedDate;
  final String completedDate;
  final bool status;

  TaskInfoPage({
    required this.title,
    required this.desc,
    required this.assignedDate,
    required this.completedDate,
    required this.status,
  });

  @override
  State<TaskInfoPage> createState() => _TaskInfoPageState();
}

class _TaskInfoPageState extends State<TaskInfoPage> {
  late String assignedDate;
  late String completedDate;

  @override
  void initState() {
    super.initState();
    var dFormate = DateFormat.yMMMMEEEEd();

    // Assigned Date Parsing
    int assignedTimestamp = int.tryParse(widget.assignedDate) ?? 0;
    assignedDate = dFormate.format(
        DateTime.fromMillisecondsSinceEpoch(assignedTimestamp));

    // Completed Date Parsing
    if (widget.completedDate.isNotEmpty && int.tryParse(widget.completedDate) != null) {
      completedDate = dFormate.format(
        DateTime.fromMillisecondsSinceEpoch(
          int.parse(widget.completedDate),
        ),
      );
    } else {
      completedDate = "Not Completed Yet";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        title: Text(
          "Task Info",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      // 💡 CHANGED: Center ko Align se replace kar diya gaya hai.
      // Ab content Top-Center mein align hoga.
      body: Align(
        alignment: Alignment.topCenter, // <-- Yahan Top-Center set kiya gaya hai.
        child: Container(
          // 🛑 FIXED: Height property hata di gayi hai.
          // Ab Container apne child (Column) ke size ke hisaab se height lega.
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(21),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisSize: MainAxisSize.min is the key for wrap_content behavior
              // Yeh Column ko sirf utni hi vertical space lene deta hai jitni use chahiye.
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoSection('Title', widget.title),
                _buildInfoSection('Description', widget.desc),
                _buildInfoSection('Assigned Date', assignedDate),
                _buildInfoSection('Completed Date', completedDate),
                _buildStatusSection('Status', widget.status),
                SizedBox(height: 10), // Bottom space for good look
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget for consistent look
  Widget _buildInfoSection(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          '$label:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue.shade700),
        ),
        SizedBox(height: 4),
        // Text widget default mein wrap_content hota hai.
        Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  // Helper Widget for Status
  Widget _buildStatusSection(String label, bool status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          '$label:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue.shade700),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: status ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(width: 8),
            Text(
              status ? 'Completed' : 'Pending',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: status ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
