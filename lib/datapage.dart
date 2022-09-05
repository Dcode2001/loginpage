import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginpage/Utils.dart';
import 'package:loginpage/loginpage.dart';

class datapage extends StatefulWidget {
  const datapage({Key? key}) : super(key: key);

  @override
  State<datapage> createState() => _datapageState();
}

class _datapageState extends State<datapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Page"),
          actions: [
            IconButton(
                onPressed: () {
                  Utils.prefs!.setBool("loggedIn", false);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Loginpage();
                    },
                  ));
                },
                icon: Icon(
                  Icons.exit_to_app_outlined,
                  size: 30,
                ))
          ],
        ),
        body: WillPopScope(
            child: Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  "WELCOME",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Center(
                    child: Container(
                  child: Image(
                    image: AssetImage("myimages/myimag.png"),
                    fit: BoxFit.cover,
                  ),

                )),
              ],
            )),
            onWillPop: goback));
  }

  Future<bool> goback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return exit(0);
      },
    ));

    return Future.value();
  }
}
