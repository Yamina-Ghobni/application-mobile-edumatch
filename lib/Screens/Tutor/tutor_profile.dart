// ignore_for_file: use_key_in_widget_constructors

import 'package:edumatch/constants.dart';
import 'package:flutter/material.dart';

import 'connect.dart';

class TutorProfileScreen extends StatelessWidget {
  final Map<String, dynamic> tutor;
  const TutorProfileScreen({required this.tutor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Enseignant Info'),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: const Color(0xFFF5F5F7),
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
                      Text('${tutor['name']}',
                          style: kSubtitleTextSyule.copyWith(
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 7),
                      Text('Matiere : ${tutor['field']}',
                          style: kSubtitleTextSyule.copyWith(fontSize: 14.0)),
                      const SizedBox(height: 7),
                      Text('Institut : ${tutor['institute']}',
                          style: kSubtitleTextSyule.copyWith(fontSize: 14.0)),
                      const SizedBox(height: 7),
                      Text('Numero : ${tutor['num']}',
                          style: kSubtitleTextSyule.copyWith(fontSize: 14.0)),
                      const SizedBox(height: 7),
                      Text('Email : ${tutor['email']}',
                          style: kSubtitleTextSyule.copyWith(fontSize: 14.0)),
                      const SizedBox(height: 14),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage('${tutor['image']}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
                          Text("${tutor['description']}",
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
                              print(tutor['email']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Connect(tutorEmail: tutor['email']),
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
                                "Connect",
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
