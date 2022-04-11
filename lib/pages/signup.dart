import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_add_firebase/pages/login.dart';
import 'package:login_signup_add_firebase/pages/user_main.dart';
import 'package:login_signup_add_firebase/services/form_validate.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  var emailsignup = "";
  var passwordsignup = "";
  var confarmpasswrodsignup = "";

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    conpasswordcontroller.dispose();
    super.dispose();
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conpasswordcontroller = TextEditingController();

  registration() async {
    if (passwordsignup == confarmpasswrodsignup) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailsignup, password: passwordsignup);
        print(userCredential);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Registration Complite ",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.red,
        ));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          print(" Password is too Weak");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Password is too weak",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            backgroundColor: Colors.red,
          ));
        } else if (error.code == 'email-already-in-use') {
          print("Email already in use");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Email already in use",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            backgroundColor: Colors.red,
          ));
        }
      }
    } else {
      print("Password and Confram Password is not match");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Password and Confram password is not match",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.width * .5,
                child: Image.asset("images/signuppage.png"),
              ),

              TextFormField(
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                  labelText: "Email",
                  errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                controller: emailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email Address";
                  } else if (!value.contains('@')) {
                    return "Email is unvalid ";
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 15,
              ),
              // Password
              TextFormField(
                autofocus: false,
                controller: passwordcontroller,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: " Password ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                  errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 25,
                  ),
                  prefixIconColor: Colors.purple,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " Enter Your Password";
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 15,
              ),

              //Confram Password

              TextFormField(
                controller: conpasswordcontroller,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Confram Password",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                  errorStyle: TextStyle(fontSize: 15, color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                  prefixIconColor: Colors.greenAccent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " Enter your confram password";
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 15,
              ),

              // Sign Up Button

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          emailsignup=emailcontroller.text;
                          passwordsignup=passwordcontroller.text;
                          confarmpasswrodsignup=conpasswordcontroller.text;
                        });
                        registration();
                      },
                      child: Text(
                        " Sign Up ",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 35,
              ),

              // Sign in actant
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(" Your accound alredy  create ? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  LoginPage(),
                              transitionDuration: Duration(seconds: 0)));
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 25, color: Colors.redAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
