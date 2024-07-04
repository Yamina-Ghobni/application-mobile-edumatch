// ignore_for_file: prefer_const_constructors

import 'package:edumatch/Screens/Pack/myPack.dart';
import 'package:edumatch/Screens/Request/participation.dart';
import 'package:edumatch/Screens/Tutor/tutor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/Pack/pack.dart';
import 'Screens/Profile/profile_screen.dart';
import 'Screens/Request/request.dart';
import 'constants.dart';

class HiddenDrawerTutor extends StatefulWidget {
  const HiddenDrawerTutor({Key? key}) : super(key: key);

  @override
  State<HiddenDrawerTutor> createState() => _HiddenDrawerTutorState();
}

class _HiddenDrawerTutorState extends State<HiddenDrawerTutor> {
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
              name: 'Mes Packs',
              baseStyle: myTextStyle,
              selectedStyle: TextStyle(),
              colorLineSelected: kDarkColor),
          MyPacks()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Demandes',
              baseStyle: myTextStyle,
              selectedStyle: TextStyle(),
              colorLineSelected: kDarkColor),
            RequestScreen()),
            ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Participations',
              baseStyle: myTextStyle,
              selectedStyle: TextStyle(),
              colorLineSelected: kDarkColor),
            ParticipationScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Profil',
              baseStyle: myTextStyle,
              selectedStyle: TextStyle(),
              colorLineSelected: kDarkColor),
          ProfileScreen()),
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
