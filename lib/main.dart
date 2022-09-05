import 'package:flutter/material.dart';
import 'package:loginpage/Utils.dart';
import 'package:loginpage/datapage.dart';
import 'package:loginpage/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async{

  WidgetsFlutterBinding.ensureInitialized();

  Utils.prefs = await SharedPreferences.getInstance();


  runApp(MaterialApp(
    home: Utils.prefs!.getBool("loggedIn") == true ? datapage() : Loginpage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.purple),
  ));
}
