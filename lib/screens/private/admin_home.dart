import '../../models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  final User user;
  final int currentIndex;
  final Function changeBottomIndex;
  AdminHome({
    this.user,
    this.currentIndex,
    this.changeBottomIndex,
  });
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  //Facility _facility;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Center(child: Text('Admin Home')),
    );
  }
}
