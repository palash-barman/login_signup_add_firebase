import 'package:flutter/material.dart';
import 'package:login_signup_add_firebase/user/change_pass.dart';
import 'package:login_signup_add_firebase/user/dashbord.dart';
import 'package:login_signup_add_firebase/user/profile.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _selectIndex = 0;

  static List<Widget> _widgetOption = <Widget>[
    DeshBord(),
    Profile(),
    ChangePass(),
  ];

  void onItemtappad(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOption.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items:const<BottomNavigationBarItem> [

          BottomNavigationBarItem(
              icon:Icon(Icons.home),
          label:'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person),
          label: "Profile",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings),
          label: 'Settings'
          ),

        ],

        currentIndex: _selectIndex,
        selectedItemColor: Colors.greenAccent,
        onTap: onItemtappad,
      ),


    );
  }
}
