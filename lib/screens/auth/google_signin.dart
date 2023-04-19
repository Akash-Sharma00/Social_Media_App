import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/common/my_widget.dart';
import 'package:social_media/repos/all_apis.dart';

class AuthFeature {
  signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken, accessToken: gAuth.accessToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    User? fireUSer = auth.currentUser;

    Repositories().addUser(
        id: fireUSer!.uid,
        name: gUser.displayName,
        username: gUser.id,
        description: '',
        mail: gUser.email,
        imagelink: gUser.photoUrl,
        hobby: "add hobbies",
        number: '');
    return;
  }

  logInWithmail(String mail, String pass, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: mail,
        password: pass,
      );
      user = userCredential.user;
      await user!.reload();
      user = auth.currentUser;
    } catch (e) {
      if (kDebugMode) {
        mySnackBar(context, "Invalide credential");
      }
    }
    return user;
  }

  signInWithMail(
      {required String name,
      required String number,
      required String username,
      required String description,
      required String mail,
      required String pass,
      required String hobby,
      File? image,
      required BuildContext context}) async {
    String? url;
    FirebaseStorage storage = FirebaseStorage.instance;

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: mail,
        password: pass,
      )
          .whenComplete(() async {
        user = auth.currentUser;
        Reference reference = storage.ref().child("profiles/${user!.uid}");
        if (image != null) {
          await reference.putFile(image);
          url = await reference.getDownloadURL();
        }
        Repositories().addUser(
            id: user!.uid,
            name: name,
            number: number,
            username: username,
            description: description,
            mail: mail,
            imagelink: url,
            hobby: hobby);
      });
    } catch (e) {
      if (kDebugMode) {
        mySnackBar(context, "$e");
        print(e);
      }
    }
    return user;
  }
}
