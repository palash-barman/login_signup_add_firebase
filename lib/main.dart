import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_add_firebase/pages/login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future <FirebaseApp> _inatialition = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
          future: _inatialition,
          builder: (context, snapshot){
            if(snapshot.hasError){
              print("Somethin is worng");
            }
            if(snapshot.connectionState==ConnectionState.waiting){

              return Center(child:CircularProgressIndicator(),);
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Flutter Email & Password",
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),

              home: LoginPage(),

            );

          },


        );
  }
}
