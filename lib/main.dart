import 'package:flutter/material.dart';
import 'package:edumatch/Screens/Welcome/welcome_screen.dart';
import 'package:edumatch/constants.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduMatch',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 50, // Set the height of the AppBar
            titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
            color: Color(0xFFE2C0E8), // Set the app bar color.
            iconTheme: IconThemeData(
              color: Colors.white, // Set the color of the app bar icons.
            ),
          ),
          primaryColor: kPrimaryColor,
          //primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
    );
  }
}
