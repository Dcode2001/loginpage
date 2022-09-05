import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginpage/DbHelper.dart';
import 'package:loginpage/Utils.dart';
import 'package:loginpage/datapage.dart';
import 'package:loginpage/signuppage.dart';
import 'package:sqflite/sqflite.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool rem = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  Database? db;

  bool isvisible = true;

  Login() async {
    db = await DbHelper().CreateDatabase();

    String username = _name.text;
    String password = _password.text;

    await DbHelper().loginuser(username, password).then((userdata) {
      if (userdata != null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return datapage();
          },
        ));
      } else {
        print("============= Not Ans =============");

        Fluttertoast.showToast(
            msg: "Wrong.....!!!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: AssetImage("myimages/img_7.png"),
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 180),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 55,
                                width: 140,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(colors: [
                                      Colors.purple,
                                      Colors.pink,
                                      Colors.purpleAccent
                                    ])),
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(

                              controller: _name,
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: "Username",
                                  labelText: "Username",
                                  labelStyle: TextStyle(fontSize: 17))),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                              controller: _password,
                              obscureText: isvisible,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  labelText: "Password",
                                  hintText: "Password",
                                  labelStyle: TextStyle(fontSize: 17),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isvisible = !isvisible;
                                        });
                                      },
                                      icon: Icon(isvisible
                                          ? Icons.visibility_off
                                          : Icons.visibility)))),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Colors.amber,
                                activeColor: Colors.purple,
                                // value: _terms,
                                onChanged: (value) {
                                  setState(() {
                                    rem = value!;
                                  });
                                },
                                value: rem,
                              ),
                              Text(
                                "Remember Me?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                String username = _name.text;
                                String password = _password.text;

                                Utils.prefs!.setBool("loggedIn", true);

                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                //   return datapage();
                                // },));
                                if (username == "" || password == "") {
                                  Fluttertoast.showToast(
                                      msg: "Fill Username & Password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                                  //     return Loginpage();
                                  //   },
                                  // ));
                                  Login();
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.lightBlue)),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              )),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return Signuppage();
                                    },
                                  ));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(29)),
                                  child: Image(
                                    image: AssetImage("myimages/img_5.png"),
                                    height: 80,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Need an Account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return Signuppage();
                                    },
                                  ));
                                },
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
