import 'package:flutter/material.dart';
class DeshBord extends StatefulWidget {

  @override
  _DeshBordState createState() => _DeshBordState();
}

class _DeshBordState extends State<DeshBord> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding:EdgeInsets.all(10),
      child: Image.asset("images/deshbord.jpg"),
      ),
      
      
      
    );
  }
}
