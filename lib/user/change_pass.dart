import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_add_firebase/pages/login.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final formkey = GlobalKey<FormState>();
  var newpassword = "";

  TextEditingController newpasswordctrl = TextEditingController();

  @override
  void dispose() {
    newpasswordctrl.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final curentUser = FirebaseAuth.instance.currentUser;

  changePassword() async {
    try {
      await curentUser!.updatePassword(newpassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Change Your Password that login page",
          style: TextStyle(fontSize: 25, color: Colors.purpleAccent),
        ),
        backgroundColor: Colors.grey,
      ));
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/change.jpg"), fit: BoxFit.cover),
      ),
      child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),

                // Padding(padding: EdgeInsets.all(20),
                // child: Image.asset('images/change.jpg'),
                // ),

                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'new password',
                      hintText: 'Enter new password',
                      labelStyle:
                          TextStyle(fontSize: 20, color: Colors.purpleAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorStyle: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    controller: newpasswordctrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Enter New Password";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          newpassword = newpasswordctrl.text;
                        });
                        changePassword();
                      }
                    },
                    child: Text(
                      'Chnage Password',
                      style: TextStyle(fontSize: 20, color: Colors.pinkAccent),
                    ))
              ],
            ),
          )),
    ));
  }
}
