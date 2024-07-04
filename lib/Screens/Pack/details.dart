// ignore_for_file: use_key_in_widget_constructors

import 'package:edumatch/Screens/Pack/participate.dart';
import 'package:edumatch/constants.dart';
import 'package:flutter/material.dart';

class PackDetails extends StatelessWidget {
  final Map<String, dynamic> pack;
  const PackDetails({required this.pack});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Pack Info'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("${pack['image']}"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${pack['name']}", style: kHeadingextStyle),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () => {},
                            icon: Icon(
                              Icons.class_outlined,
                              color: kTextColor.withOpacity(.5),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text("Niveau : ${pack['level']}",
                              style: kSubtitleTextSyule.copyWith(fontSize: 17)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => {},
                            icon: Icon(
                              Icons.money,
                              color: kTextColor.withOpacity(.5),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: " Prix : \TND ${pack['price']} ",
                                  style:
                                      kSubtitleTextSyule.copyWith(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => {},
                            icon: Icon(
                              Icons.person_2_outlined,
                              color: kTextColor.withOpacity(.5),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: " Enseignant : ${pack['tutor_email']} ",
                                  style:
                                      kSubtitleTextSyule.copyWith(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("À propos", style: kTitleTextStyle),
                          const SizedBox(height: 30),
                          Text("${pack['description']}",
                              style:
                                  kSubtitleTextSyule.copyWith(fontSize: 16.0)),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 50,
                              color: kTextColor.withOpacity(.1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Participate(tutorEmail: pack['tutor_email'], packLabel: pack['name']),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    kPrimaryColor,
                                    Color(0xFFE8A0BF),
                                  ],
                                ),
                              ),
                              child: Text(
                                "Participer",
                                style: kSubtitleTextSyule.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
