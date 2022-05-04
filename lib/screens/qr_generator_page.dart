import 'dart:typed_data';

import 'package:dictionary/models/my_toast.dart';
import 'package:dictionary/style/style.dart';
import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';




class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
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
                  myToast("Photo Saved To Gallery");
                screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  showCapturedWidget(context, capturedImage!);
                }).catchError((onError) {

                });

              },
                fillColor: AppStyle.accentColor,
                shape:  const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
                child:  Row(

                  mainAxisSize: MainAxisSize.min,

                  children: const [
                     Text("Save QR Code", style: TextStyle(
                      fontSize: 24,
                      color: Colors.white, fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(width: 15,),

                    Icon(Icons.save_alt_rounded, color: Colors.white,size: 35,)

                  ],
                ),)
            ],
          ),
        ));

  }
  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) async{
    return _saved(capturedImage);
  }



  _saved(Uint8List image) async {
     ImageGallerySaver.saveImage(image);

  }


}






