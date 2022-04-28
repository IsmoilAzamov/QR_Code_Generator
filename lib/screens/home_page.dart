import 'dart:typed_data';

import 'package:dictionary/style/style.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String data = "";

   ScreenshotController screenshotController=ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Screenshot(
             controller: screenshotController,
             child: Center(
              child: QrImage(

                data: data,
                backgroundColor: Colors.white,
                size: 300,
                version: QrVersions.auto,

              ),
          ),

           ),
          const SizedBox(
            height: 24,
          ),

          SizedBox(
            width: 300,
            child:  TextField(
              onChanged: (value){
                setState(() {
                  data=value;
                });
              },
              textAlign: TextAlign.center,
              decoration: const InputDecoration(

                  hintText: "Enter Your Link",
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  fillColor: Colors.white),
              style: const  TextStyle(
                color: Colors.blue,
                fontSize: 21,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 24,),
          RawMaterialButton(onPressed: (){
            screenshotController
                .capture(delay: const Duration(milliseconds: 10))
                .then((capturedImage) async {
              showCapturedWidget(context, capturedImage!);
            }).catchError((onError) {

            });

          },
          fillColor: AppStyle.accentColor,
          shape:  const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 66, vertical: 26),
          child: const Text("Share QR Code", style: TextStyle(
            fontSize: 24,
            color: Colors.white, fontWeight: FontWeight.bold,
          ),),)
        ],
      ),
    ));

  }
  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) async{
    return _saved(capturedImage);
  }



  _saved(Uint8List image) async {
    final result = await ImageGallerySaver.saveImage(image);

  }


}






