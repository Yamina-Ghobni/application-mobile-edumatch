import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../hidden_drawer_tutor.dart';

class AddPack extends StatelessWidget {
  const AddPack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Creation de Pack'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/back.png"), // replace this with your image path
                fit: BoxFit.fill,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: defaultPadding * 2),
                  const Text(
                    "Un espace pour creer un pack",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  Row(
                    children: const [
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: AddPackForm(),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddPackForm extends StatefulWidget {

  const AddPackForm({
    Key? key,
  }) : super(key: key);

  @override
  _AddPackFormState createState() => _AddPackFormState();
}

class _AddPackFormState extends State<AddPackForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController NameController = new TextEditingController();
  final TextEditingController LevelController = new TextEditingController();
  final TextEditingController PriceController = new TextEditingController();
  final TextEditingController ImageController = new TextEditingController();
  final TextEditingController DescriptionController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: NameController,
            decoration: InputDecoration(
              labelText: 'Label',
              labelStyle: const TextStyle(
                // color: Color(0xFFE2C0E8),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE2C0E8),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFC0DBEA),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer une valeur';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: LevelController,
            decoration: InputDecoration(
              labelText: 'Niveau',
              labelStyle: const TextStyle(
                // color: Color(0xFFE2C0E8),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE2C0E8),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFC0DBEA),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer une valeur';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: PriceController,
            decoration: InputDecoration(
              labelText: 'Prix',
              labelStyle: const TextStyle(
                // color: Color(0xFFE2C0E8),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE2C0E8),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFC0DBEA),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer une valeur';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: ImageController,
            decoration: InputDecoration(
              labelText: 'Image',
              labelStyle: const TextStyle(
                // color: Color(0xFFE2C0E8),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE2C0E8),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFC0DBEA),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer une valeur';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            minLines: 2,
            maxLines: 5,
            controller: DescriptionController,
            decoration: InputDecoration(
              labelText: 'Contenu',
              labelStyle: const TextStyle(
                // color: Color(0xFFE2C0E8),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE2C0E8),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFC0DBEA),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrer une valeur';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                createPack(NameController.text, 
                LevelController.text, 
                PriceController.text, 
                ImageController.text, 
                DescriptionController.text);
                // if (role == "Enseignant") {
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => HiddenDrawerTutor(),
                //     ),
                //   );
                // } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HiddenDrawerTutor(),
                    ),
                  );
                // }
              }
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
                    Color(0xFFE2C0E8),
                    Color(0xFFC0DBEA),
                  ],
                ),
              ),
              child: Text(
                "Create",
                style: kSubtitleTextSyule.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

    String generateId() {
      final random = Random();
      final id = random.nextInt(1000000); // generate a random number between 0 and 999999
      return id.toString();
    }

  Future<void> createPack(
    String name,
    String level,
    String price,
    String image,
    String description,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;
    final id = generateId();
    try {
      await firestoreInstance.collection('packs').add({
        'id': id,
        'tutor_email': user?.email,
        'name': name,
        'level': level,
        'price': price,
        'image': image,
        'description': description,
      });
    } catch (e) {
      print('Error sending pack: $e');
      rethrow;
    }
  }
}
