// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumatch/Screens/Pack/addPack.dart';
import 'package:edumatch/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyPacks extends StatefulWidget {
  const MyPacks({Key? key}) : super(key: key);

  @override
  State<MyPacks> createState() => _MyPacksState();
}

class _MyPacksState extends State<MyPacks> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  List<Map<String, dynamic>> Packs = [];
  String? name;

  @override
  void initState() {
    getPacksData();
    super.initState();
  }

  void getPacksData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('packs')
        .where('tutor_email', isEqualTo: user.email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      List<Map<String, dynamic>> PacksData = documents.map((document) {
        return document.data() as Map<String, dynamic>;
      }).toList();
      setState(() {
        Packs = PacksData;
        print(Packs);
      });
    } else {
      print('No Packs found with this user');
    }
  }

  void deletePack(int index) async {
    String id = Packs[index]['id'];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('packs')
        .where('id', isEqualTo: id)
        .get();

    if (snapshot.size > 0) {
      String documentId = snapshot.docs[0].id;
      await FirebaseFirestore.instance
          .collection('packs')
          .doc(documentId)
          .delete();
    }

    setState(() {
      Packs.removeAt(index);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Mes Packs',
                  style: TextStyle(
                    color: kPinkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AddPack(),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFE8A0BF),
                          Color(0xFFE2C0E8),
                        ],
                      ),
                    ),
                    child: Text(
                      "Créer",
                      style: kSubtitleTextSyule.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(0),
                crossAxisCount: 2,
                itemCount: Packs.length,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 10, right: 20),
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
                                Packs[index]['name'],
                                style: const TextStyle(
                                  color: kDarkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                onPressed: () => deletePack(index),
                                icon: Icon(
                                  Icons.delete,
                                  color: kTextColor.withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Niveau : ${Packs[index]['level']}',
                            style: TextStyle(
                              color: kTextColor.withOpacity(.5),
                            ),
                          ),
                          Text(
                            'Prix : ${Packs[index]['price']}',
                            style: TextStyle(
                              color: kTextColor.withOpacity(.5),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${Packs[index]['description']}',
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
