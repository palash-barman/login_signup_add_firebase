
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_add_firebase/pages/login.dart';
import 'package:login_signup_add_firebase/pages/signup.dart';
class ForgetPage extends StatefulWidget {
  const ForgetPage({Key? key}) : super(key: key);

  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {

  final _forgetkeys= GlobalKey<FormState>();

  var _email;

 final _emailctrl = TextEditingController();

 resetPassword()async{
   try{
   await FirebaseAuth.instance.sendPasswordResetEmail(email: _email).then((uid) => {

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     content: Text(" Password email has been sent !",
     style: TextStyle(fontSize: 25, ),
     ),
     backgroundColor: Colors.grey,

     )),

     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
     });

   }on FirebaseAuthException catch(error){
    if(error.code=='user-not-found'){
      print("No user found for that email");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("No user found for that email",
          style: TextStyle(fontSize: 25,color: Colors.red),
          ),
      backgroundColor: Colors.grey,
      ));
    }
   }
 }

 @override
  void dispose() {
    _emailctrl.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Reset Password "),
      ),
      body: Column(

        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Image.asset("images/forget.jpg"),
          ),
          SizedBox(height: 10,),

          Container(
           margin: EdgeInsets.all(12),
            child: Text("Reset link will be sent to your email Id ? ",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.pink),
            ),
          ),

          Expanded(
              child:Form(
                key: _forgetkeys,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 15,color:Colors.pink),
                          labelText: 'email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.purple,
                            )
                          ),
                        ),
                        controller: _emailctrl,
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return " Please enter email ";
                          }
                          else if(!value.contains('@')){
                            return "Enter your valid email";
                          }
                          return null;
                        },
                      ),
                    ),

                    // send email & Login Button

                    Container(
                      margin:EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: (){
                            if(_forgetkeys.currentState!.validate()){
                              setState(() {
                                _email=_emailctrl.text;
                              });
                              resetPassword();
                            }

                          },
                              child: Text("Send Email",
                              style: TextStyle(fontSize: 25,color: Colors.black),
                              ),
                          ),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          },
                              child:Text("Login",
                              style: TextStyle(fontSize: 20,color:Colors.pink),
                              ),
                          ),


                        ],

                      ),


                    ),

                    // Sign Up button

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" Do not Have Accound ?",
                          style: TextStyle(fontSize: 15),
                          ),
                          TextButton(onPressed: (){
                            Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b)=>SignUp(),
                            transitionDuration: Duration(seconds: 0),
                            ), (route) => false);
                          },
                              child: Text("Sign Up",
                              style: TextStyle(fontSize: 20,color: Colors.red),
                              ))


                        ],


                      ),



                    )





                  ],
                ),


                ),
              ),



          )



        ],

      )
      
      
      
    );
  }
}
