import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumatch/Screens/Pack/details.dart';
import 'package:edumatch/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PackScreen extends StatefulWidget {
  const PackScreen({Key? key}) : super(key: key);

  @override
  State<PackScreen> createState() => _PackScreenState();
}

class _PackScreenState extends State<PackScreen> {
  @override
  List<Map<String, dynamic>> packs = [];
  List<Map<String, dynamic>> _packsFound = [];


  @override
  void initState() {
    getPacksData();
    super.initState();
  }

  void getPacksData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('packs')
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      List<DocumentSnapshot> documents = querySnapshot.docs;
      List<Map<String, dynamic>> packsData = documents.map((document) {
        return document.data() as Map<String, dynamic>;
      }).toList();
      setState(() {
        packs = packsData;
        _packsFound = packs;
      });
    } else {
      print('No packs found');
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = packs;
    } else {
      results = packs
          .where((item) =>
              item["name"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              item["level"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _packsFound = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            const Text("Salut,", style: kTitleTextStyle),
            const Text("Trouvez le pack de revision adequat pour vous!",
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
                itemCount: _packsFound.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PackDetails(pack: _packsFound[index],)
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: index.isEven ? 180 : 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(_packsFound[index]['image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _packsFound[index]['name'],
                              style: kTitleTextStyle,
                            ),
                            Text(
                              'Niveau : ${_packsFound[index]['level']}',
                              style: TextStyle(
                                color: kTextColor.withOpacity(.5),
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
