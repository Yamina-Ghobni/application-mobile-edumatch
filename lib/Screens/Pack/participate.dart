import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../hidden_drawer_student.dart';
import '../../hidden_drawer_tutor.dart';

class Participate extends StatelessWidget {
  const Participate({Key? key, required this.tutorEmail, required this.packLabel}) : super(key: key);
  final String tutorEmail;
  final String packLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Inscription'),
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
                    "Un espace pour s'inscrire a un pack",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  Row(
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: ParticipateForm(reciever: tutorEmail, packWanted: packLabel,),
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

class ParticipateForm extends StatefulWidget {
  final String reciever; // add this variable
  final String packWanted; // add this variable

  const ParticipateForm({
    Key? key,
    required this.reciever, // add this parameter
    required this.packWanted, // add this parameter
  }) : super(key: key);

  @override
  _ParticipateFormState createState() => _ParticipateFormState();
}

class _ParticipateFormState extends State<ParticipateForm> {
  final _formKey = GlobalKey<FormState>();
  String? role;
  final TextEditingController NameController = new TextEditingController();
  final TextEditingController NumController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  void getUserRole() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          role = documentSnapshot.get('role');
        });
      } else {
        print('Document does not exist on the database');
      }
    });
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
              labelText: 'Nom & Prenom',
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
            controller: NumController,
            decoration: InputDecoration(
              labelText: 'Numero',
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
                sendRequest(NameController.text, NumController.text);
                if (role == "Enseignant") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HiddenDrawerTutor(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HiddenDrawerStudent(),
                    ),
                  );
                }
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
                "Send",
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

  Future<void> sendRequest(
    String senderName,
    String senderNumber,
  ) async {
    // get the Firestore instance
    User? user = FirebaseAuth.instance.currentUser;
    final firestoreInstance = FirebaseFirestore.instance;
    final id = generateId();

    try {
      // add the message to the Firestore collection
      await firestoreInstance.collection('participations').add({
        'id': id,
        'pack': widget.packWanted,
        'tutor_email': widget.reciever,
        'sender_name': senderName,
        'sender_email': user?.email,
        'sender_number': senderNumber,
      });
    } catch (e) {
      print('Error sending message: $e');
      rethrow;
    }
  }
}
