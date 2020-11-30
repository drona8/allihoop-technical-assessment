import '../../styles/color.dart';
import '../../styles/style.dart';
import '../../widgets/avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../screens/private/user_home.dart';
import '../../services/auth/auth_service.dart';
import 'admin_home.dart';

class HomeWrapper extends StatefulWidget {
  final User user;
  HomeWrapper({
    this.user,
  });

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _currentIndex;

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: _checkRoleAndResolveBody(context),
      drawer: _getDrawer(context),
      bottomNavigationBar: null,
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      title: Text('Allihoop'),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_sharp,
            color: AppColor.whiteText,
          ),
          onPressed: () {},
        ),
        AvatarWidget(
          imageURL: widget.user.imageUrl,
        ),
        SizedBox(
          width: 15,
        )
      ],
    );
  }

  Drawer _getDrawer(BuildContext context) {
    return new Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: DrawerHeader(
              margin: EdgeInsets.only(top: 20),
              decoration: new BoxDecoration(),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      widget.user.firstName,
                      style: hintStyleAppBarTitle(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListTile(
                title: Text(
                  'Log out',
                  style: hintStyleListTileText(),
                ),
                onTap: () async {
                  final AuthService authService =
                      Provider.of<AuthService>(context, listen: false);
                  await authService.signOut();
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkRoleAndResolveBody(BuildContext context) {
    return widget.user.type == 'admin'
        ? AdminHome(
            user: widget.user,
            currentIndex: _currentIndex,
            changeBottomIndex: null,
          )
        : UserHome(
            user: widget.user,
          );
  }
}
