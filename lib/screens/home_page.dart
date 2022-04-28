import 'package:dictionary/style/style.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String data = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: QrImage(
              data: data,
              backgroundColor: Colors.white,
              size: 300,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Enter Your Link",
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  fillColor: Colors.white),
              style: TextStyle(
                color: Colors.blue,
                fontSize: 21,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
