import 'package:dictionary/screens/qr_generator_page.dart';
import 'package:dictionary/screens/qr_scanner_page.dart';
import 'package:dictionary/style/style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.primaryColor,

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(

              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.black26, 
                  borderRadius: BorderRadius.circular(50)),
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: GestureDetector(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyHome()));
                                  },
                    child: Column(
                      children: [
                       Image.asset('assets/img.png'),
                        const SizedBox(
                          height: 0,
                        ),
                        const Text(
                          "Scan ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GeneratorPage()),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/qrcode.png'),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "Generate ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
