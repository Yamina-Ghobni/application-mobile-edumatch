// ignore_for_file: prefer_const_constructors

import 'package:edumatch/Screens/Request/activityPack.dart';
import 'package:edumatch/Screens/Request/activityRequest.dart';
import 'package:edumatch/Screens/Tutor/tutor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/Pack/pack.dart';
import 'constants.dart';

class HiddenDrawerStudent extends StatefulWidget {
  const HiddenDrawerStudent({Key? key}) : super(key: key);

  @override
  State<HiddenDrawerStudent> createState() => _HiddenDrawerStudentState();
}

class _HiddenDrawerStudentState extends State<HiddenDrawerStudent> {
  List<ScreenHiddenDrawer> _pages = [];

  final myTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 18, color: kPrimaryColor);

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Enseignants',
              baseStyle: myTextStyle,
              selectedStyle: TextStyle(),
              colorLineSelected: kDarkColor),
          TutorScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Packs',
              baseStyle: myTextStyle,
              selectedStyle: TextStyle(),
              colorLineSelected: kDarkColor),
          PackScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Contacts',
              baseStyle: myTextStyle,
              selectedStyle: TextStyle(),
              colorLineSelected: kDarkColor),
          ActivityRequest()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Participations',
              baseStyle: myTextStyle,
              selectedStyle: TextStyle(),
              colorLineSelected: kDarkColor),
          ActivityPack()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Logout',
            baseStyle: myTextStyle,
            selectedStyle: TextStyle(),
            colorLineSelected: kDarkColor,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
        Container(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: kPrimaryLightColor,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 40,
      contentCornerRadius: 20,
    );
  }
}
