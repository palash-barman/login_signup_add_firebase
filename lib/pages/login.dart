import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_add_firebase/pages/forgetpass.dart';
import 'package:login_signup_add_firebase/pages/signup.dart';
import 'package:login_signup_add_firebase/pages/user_main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keys = GlobalKey<FormState>();

  var email = " ";
  var password = " ";

  final emailctrl = TextEditingController();
  final passwordctrl = TextEditingController();

  getLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password.trim()).then((uid) =>{

            Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => UserMain())),
      } );

    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print("No user found that email");

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "No user found that email",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          backgroundColor: Colors.red,
        ));
      } else if (error.code == 'wrong-password') {
        print("Password is wrong");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Password is wrong",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailctrl.dispose();
    passwordctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _keys,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images/logina.png"),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: " Email ",
                        labelStyle: TextStyle(fontSize: 20),
                        errorStyle:
                            TextStyle(fontSize: 15, color: Colors.black87),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          size: 25,
                        )),
                    controller: emailctrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " please enter email";
                      } else if (!value.contains('@')) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 20),
                        errorStyle:
                            TextStyle(fontSize: 15, color: Colors.black26),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          size: 25,
                        )),
                    controller: passwordctrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Login Button

                      ElevatedButton(
                        onPressed: () {
                          if (_keys.currentState!.validate()) {
                            setState(() {
                              email = emailctrl.text;
                              password = passwordctrl.text;
                            });
                            getLogin();
                          }
                        },

                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.purple,
                          ),
                        ),
                      ),

                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPage()));
                          },
                          child: Text(
                            "Forget Password ?",
                            style: TextStyle(fontSize: 15),
                          )),
                    ],
                  ),
                ),

                // Sign Up Button

                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have accound ? ",
                        style: TextStyle(
                            fontSize: 15, color: Colors.lightBlueAccent),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, a, b) => SignUp(),
                                    transitionDuration: Duration(seconds: 0)),
                                (route) => false);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
