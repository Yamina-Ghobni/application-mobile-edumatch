// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumatch/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  List<Map<String, dynamic>> messages = [];
  String? name;

  @override
  void initState() {
    getMessagesData();
    super.initState();
  }

  void getMessagesData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .where('tutor_email', isEqualTo: user.email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      List<Map<String, dynamic>> messagesData = documents.map((document) {
        return document.data() as Map<String, dynamic>;
      }).toList();
      setState(() {
        messages = messagesData;
        print(messages);
      });
    } else {
      print('No messages found with this user');
    }
  }

   void deleteMessage(int index) async {
    String id = messages[index]['id'];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('messages')
        .where('id', isEqualTo: id)
        .get();

    if (snapshot.size > 0) {
        String documentId = snapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('messages')
            .doc(documentId)
            .delete();
    }

    setState(() {
        messages.removeAt(index);
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
                itemCount: messages.length,
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
                                messages[index]['sender_name'],
                                style: const TextStyle(
                                  color: kDarkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                onPressed: () => deleteMessage(index),
                                icon: Icon(
                                  Icons.delete,
                                  color: kTextColor.withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Email : ${messages[index]['sender_email']}',
                            style: TextStyle(
                              color: kTextColor.withOpacity(.5),
                            ),
                          ),
                          Text(
                            'Numero : ${messages[index]['sender_number']}',
                            style: TextStyle(
                              color: kTextColor.withOpacity(.5),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${messages[index]['message']}',
                            style: TextStyle(
                              color: kTextColor.withOpacity(1),
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