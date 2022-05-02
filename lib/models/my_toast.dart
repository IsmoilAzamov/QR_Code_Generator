
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


myToast(String message){
  return Fluttertoast.showToast(msg: message,
  toastLength: Toast.LENGTH_LONG,
  timeInSecForIosWeb: 2,
  fontSize: 15,

  gravity: ToastGravity.CENTER,
  backgroundColor: Colors.blue);
}

void buildResult()=>Fluttertoast.showToast(
    msg: "Bu Toast",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
);