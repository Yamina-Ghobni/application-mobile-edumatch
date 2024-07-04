import 'package:flutter/material.dart';
import '../../constants.dart';
import 'profile_form.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Un espace pour mettre à jour votre profil",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  Row(
                    children: const [
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: ProfileForm(),
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
