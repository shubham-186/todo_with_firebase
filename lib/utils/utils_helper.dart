import 'package:flutter/material.dart';

TextField mTextField({
  Color mColor = Colors.black,
  FontWeight mFontWeight = FontWeight.normal,
}) {
  return TextField(
    style: TextStyle(
      color: mColor,
      fontWeight: mFontWeight,
    ),
  );
}