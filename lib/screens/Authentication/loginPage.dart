import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_oneplanet/apis/apis.dart';
import 'package:project_oneplanet/screens/homePage.dart';
import 'package:project_oneplanet/screens/landingPage.dart';
import 'package:project_oneplanet/theme/colors.dart';

import '../../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      await APIs.auth.signInWithCredential(credential).then((value) async {
        APIs.user;
        String id = APIs.user!.uid;

        await APIs.firestore.collection('users').doc(id).get().then((value) {
          if (value.exists) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LandingPage(
                  currentUser: APIs.user!,
                ),
              ),
            );
          } else {
            UserModel newUser = UserModel(
              id: id,
              name: APIs.user!.displayName,
              photo: APIs.user!.photoURL,
              points: "47",
              globalrank: "167",
              drives: "246",
              lable: "Cherry",
            );

            // Sending Userdata to fire store users collection
            APIs.firestore
                .collection("users")
                .doc(id)
                .set(newUser.toJson())
                .then((value) {
              //Navigate to homepage
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LandingPage(
                    currentUser: APIs.user!,
                  ),
                ),
              );
            });
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      log("Oops, Somthing went wrong!! ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.75,
            image: AssetImage("assets/images/login_cover.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 0.4 * screenHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffD7F8A9),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          child: Image.asset(
                            'assets/images/googlelogo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Signin with Google",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: AppColors.kDarkGreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
