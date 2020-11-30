import '../../models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  final User user;
  UserHome({
    this.user,
  });
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: Text('User Home'),
      ),
    );
  }
}
