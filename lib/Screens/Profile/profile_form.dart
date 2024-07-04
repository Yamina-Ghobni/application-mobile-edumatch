import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? field;
  String? institute;
  String? num;
  String? image;
  String? description;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Enseignant") {
          setState(() {
            field = documentSnapshot.get('field');
            name = documentSnapshot.get('name');
            institute = documentSnapshot.get('institute');
            num = documentSnapshot.get('num');
            image = documentSnapshot.get('image');
            description = documentSnapshot.get('description');
          });
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void updateUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'name': name,
      'field': field,
      'institute': institute,
      'num': num,
      'image': image,
      'description': description
    });
    print('User data updated successfully');
  }

  @override
  Widget build(BuildContext context) {
    final nameC = TextEditingController(text: name);
    final fieldC = TextEditingController(text: field);
    final instituteC = TextEditingController(text: institute);
    final numC = TextEditingController(text: num);
    final imageC = TextEditingController(text: image);
    final descriptionC = TextEditingController(text: description);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameC,
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
            onSaved: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: fieldC,
            decoration: InputDecoration(
              labelText: 'Matiere',
              labelStyle: const TextStyle(
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
            onSaved: (value) {
              setState(() {
                field = value;
              });
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: instituteC,
            decoration: InputDecoration(
              labelText: 'Institut',
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
            onSaved: (value) {
              setState(() {
                institute = value;
              });
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: numC,
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
            onSaved: (value) {
              setState(() {
                num = value;
              });
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            minLines: 1,
            maxLines: 2,
             controller: imageC,
            decoration: InputDecoration(
              labelText: 'Photo',
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
            onSaved: (value) {
              setState(() {
                image = value;
              });
            },
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            minLines: 2,
            maxLines: 5,
             controller: descriptionC,
            decoration: InputDecoration(
              labelText: 'Description',
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
            onSaved: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          const SizedBox(height: defaultPadding),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                updateUser();
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
                "Update",
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
}
