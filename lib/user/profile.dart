import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_add_firebase/pages/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationtime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  varifyemail()async{
    if(user!=null && user!.emailVerified){
      await user!.sendEmailVerification();
      print('varification email has been sent');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Varification email has been sent",
        style: TextStyle(fontSize: 25,color:Colors.pink),

      ),
        backgroundColor: Colors.grey,
      ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image:DecorationImage(
          image:AssetImage('images/profileback.jpg',
          ),
          fit: BoxFit.cover,
        )

      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("images/profile.jpg"),
          ),
          SizedBox(height: 50,),
          Column(
            children: [
              Text(
                'User Id',
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                uid,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Email : $email ',
                style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
              ),

              user!.emailVerified
              ?
                  Text('Email Verified',
                  style: TextStyle(fontSize: 20,color:Colors.yellowAccent),
                  )
                  :
              TextButton(onPressed: ()=>{
                varifyemail(),
              },
                  child:Text("Verify Email ",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.red),
                  )
              ),
            ],
          ),


          SizedBox(height: 50,),
          Column(
            children: [
              Text("Creatd",
              style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15,),

              Text(creationtime.toString(),
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(height: 50,),

          ElevatedButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage(),
            ), (route) => false);
          },
              child: Text(
                " LogOut ",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
              ),
          ),

        ],
      ),
    );
  }
}
