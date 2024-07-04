// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumatch/constants.dart';
import 'package:edumatch/Screens/Tutor/tutor_profile.dart';
import 'package:edumatch/Screens/Tutor/model/prof.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> _tutorsFound = [];
  String? name;

  @override
  void initState() {
    getTutorsData();
    super.initState();
  }

  void getTutorsData() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'Enseignant')
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    List<DocumentSnapshot> documents = querySnapshot.docs;
    List<Map<String, dynamic>> usersData = documents.map((document) {
      return document.data() as Map<String, dynamic>;
    }).toList();
    setState(() {
      users = usersData;
      _tutorsFound = users;
    });
  } else {
    print('No users found with role "Enseignant"');
  }
}

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = users;
    } else {
      results = users
          .where((item) =>
              item["name"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              item["field"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _tutorsFound = results;
    });
  }

  void getUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
          setState(() {
            name = documentSnapshot.get('name');
          });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Set the app bar to null for the home screen.
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Text('Salut,', style: kTitleTextStyle),
            const Text("Trouvez le meilleur enseignant pour vous!",
                style: kSubheadingextStyle),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                fillColor: Color(0xFFF5F5F7),
                hintText: 'Recherche',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: _tutorsFound.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TutorProfileScreen(tutor: _tutorsFound[index],),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: index.isEven ? 200 : 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFF5F5F7),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _tutorsFound[index]['name'],
                              style: kTitleTextStyle,
                            ),
                            Text(
                              'Matiere : ${_tutorsFound[index]['field']}',
                              style: TextStyle(
                                color: kTextColor.withOpacity(.5),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(_tutorsFound[index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
