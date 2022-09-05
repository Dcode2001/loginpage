import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginpage/DbHelper.dart';
import 'package:loginpage/loginpage.dart';
import 'package:sqflite/sqflite.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  bool rem = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  Database? db;

  bool isvisible = true;

  @override
  void initState() {
super.initState();
DbHelper().CreateDatabase().then((value)
{
    db = value;
}
);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            body: Stack(fit: StackFit.expand, children: [
          Image(
            image: AssetImage("myimages/img_4.png"),
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.2),
            colorBlendMode: BlendMode.darken,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      // SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return Loginpage();
                              },
                            ));
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                  child: Icon(
                                Icons.arrow_back,
                                size: 35,
                              ))),splashColor: Colors.brown,
                        ),
                      ],
                    ),
                    SizedBox(height: 90),

                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 55,
                          width: 170,
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
                              "SIGN UP",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    Container(
                      child: TextField(
                        controller: _name,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        labelText: "Username",
                        hintText: "Username",
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _password,
                        keyboardType: TextInputType.multiline,
                        obscureText: isvisible,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          labelText: "Password",
                          hintText: "Password",
                          suffixIcon: IconButton(onPressed: () {
                                setState(() {
                                  isvisible = !isvisible;
                                });
                          }, icon: Icon(isvisible ? Icons.visibility_off : Icons.visibility))
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {

                          String username = _name.text;
                          String password = _password.text;

                          String qry = "insert into Test(name,password) values('$username','$password')";

                          int a = await db!.rawInsert(qry);

                          print(a);

                          if( username == "" || password == "")
                          {
                            Fluttertoast.showToast(
                                msg: "Fill Username & Password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);

                          }
                        else
                          {


                            // if()
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return Loginpage();
                            },));
                          }
}

                        ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(fontSize: 20),
                        )),
                    SizedBox(height: 220),
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
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a User?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18,color: Colors.grey.shade300),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return Loginpage();
                              },
                            ));
                          },
                          child: Text(
                            "LOGIN",
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
          )
        ])),
        onWillPop: goback);
  }

  Future<bool> goback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Loginpage();
      },
    ));
    return Future.value();
  }
}
