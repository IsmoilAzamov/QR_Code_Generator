//import 'package:dictionary/style/style.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:developer';
import 'dart:io';

import 'package:dictionary/style/style.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(const MaterialApp(home: MyHome()));

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRViewExample();
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Icon cameraIcon = Icon(
    Icons.camera_alt_outlined,
    size: 35,
  );
  Icon pauseIcon = Icon(
    Icons.pause,
    size: 35,
  );
  Color a = Colors.white;
  Color b = Colors.white;
  Color c = Colors.white;


  Barcode? result;
  bool isplayingCamera = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
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

  Widget showResult()=>Text(
    result!=null?'${result!.code  }':'Scanning code...',
    maxLines: 3,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
         
         //777777777777777777777777777777777777777777777777777777777777777777777
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Positioned(bottom:30, child: showResult()),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: GestureDetector(
                            onTap: () async {
                              await controller?.toggleFlash();
                              setState(() {
                                if(c==Colors.white)c=Colors.yellowAccent;
                                else c=Colors.white;
                              });
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return CircleAvatar(radius: 25,
                                  child: Icon(Icons.flash_on_outlined, color: c,size: 35,),
                                );
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: GestureDetector(
                            onTap: () async {
                              await controller?.flipCamera();
                              setState(() {
                                if (a == Colors.white)
                                  a = Colors.green;
                                else
                                  a = Colors.white;
                              });
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      Icons.flip_camera_ios,
                                      size: 35,
                                      color: a,
                                    ),
                                  );
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () async {
                            if (isplayingCamera == true) {
                              await controller?.resumeCamera();
                              b = Colors.red;
                              isplayingCamera = false;
                            } else {
                              b = Colors.white;
                              await controller?.pauseCamera();
                              isplayingCamera = true;
                            }
                            setState(() {
                              if (b == Colors.white) {
                                b = Colors.red;
                              } else
                                b = Colors.white;
                            });
                            buildResult();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            child: Icon(
                              Icons.pause,
                              size: 35,
                              color: b,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          //Expanded(child: Text("gfghf"))
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 240.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
    setState(() {
      this.controller = controller;

    });

  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}