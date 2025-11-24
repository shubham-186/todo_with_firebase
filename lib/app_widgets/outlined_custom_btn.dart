import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutlinedCustomBtn extends StatelessWidget{
  VoidCallback onPressed;
  String title;
  double width;
  OutlinedCustomBtn({
    required this.onPressed,
    required this.title,
    this.width = 130
});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue,
          side: BorderSide(
            width: 1,
            color: Colors.blue,
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
