// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumatch/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ParticipationScreen extends StatefulWidget {
  const ParticipationScreen({Key? key}) : super(key: key);

  @override
  State<ParticipationScreen> createState() => _ParticipationScreenState();
}

class _ParticipationScreenState extends State<ParticipationScreen> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  List<Map<String, dynamic>> participations = [];
  String? name;

  @override
  void initState() {
    getParticipationsData();
    super.initState();
  }

  void getParticipationsData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('participations')
        .where('tutor_email', isEqualTo: user.email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      List<Map<String, dynamic>> participationsData = documents.map((document) {
        return document.data() as Map<String, dynamic>;
      }).toList();
      setState(() {
        participations = participationsData;
      });
    } else {
      print('No participations found with this user');
    }
  }

   void deleteParticipation(int index) async {
    String id = participations[index]['id'];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('participations')
        .where('id', isEqualTo: id)
        .get();

    if (snapshot.size > 0) {
        String documentId = snapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('participations')
            .doc(documentId)
            .delete();
    }

    setState(() {
        participations.removeAt(index);
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //const SizedBox(height: 10),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: participations.length,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFFF5F5F7),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pack : ${participations[index]['pack']}',
                                style: const TextStyle(
                                  color: kDarkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                onPressed: () => deleteParticipation(index),
                                icon: Icon(
                                  Icons.delete,
                                  color: kTextColor.withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                          Text(
                                'Eleve : ${participations[index]['sender_name']}',
                                style: TextStyle(
                                 color: kTextColor.withOpacity(.7),
                                ),
                              ),
                          Text(
                            'Email : ${participations[index]['sender_email']}',
                            style: TextStyle(
                              color: kTextColor.withOpacity(.7),
                            ),
                          ),
                          Text(
                            'Numero : ${participations[index]['sender_number']}',
                            style: TextStyle(
                              color: kTextColor.withOpacity(.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}