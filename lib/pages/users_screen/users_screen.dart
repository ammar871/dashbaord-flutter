
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text("Users",style: TextStyle(
            color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}