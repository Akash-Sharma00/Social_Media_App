// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/all_routes/routes_const.dart';
import 'package:social_media/common/my_widget.dart';
import 'package:social_media/screens/auth/google_signin.dart';

class NewUserScreen extends StatelessWidget {
  NewUserScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  ValueNotifier<File?> imageFile = ValueNotifier(null);
  List<TextEditingController> controller =
      List.generate(7, (index) => TextEditingController());
  List<String> hints = [
    "Enter name",
    "Enter username",
    "Enter email",
    "Enter contact",
    "Enter bio(optional)",
    "Enter hobbies",
    "Enter password",
  ];
  @override
  Widget build(BuildContext context) {
    double wd = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Profile"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    imageFile.value = await pickPicture(context);
                  },
                  child: ValueListenableBuilder(
                    builder: (context, imagedata, child) {
                      if (imagedata == null) {
                        return CircleAvatar(
                            radius: wd * 0.15,
                            backgroundImage: const AssetImage(
                                "assets/images/add_profiles.png"));
                      } else {
                        return CircleAvatar(
                          radius: wd * 0.15,
                          backgroundImage: FileImage(imagedata),
                        );
                      }
                    },
                    valueListenable: imageFile,
                  ),
                ),
                for (int i = 0; i < 7; i++) textFiles(hintText: hints[i], i: i),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthFeature().signInWithMail(
                            name: controller[0].text,
                            username: controller[1].text,
                            mail: controller[2].text,
                            number: controller[3].text,
                            description: controller[4].text,
                            hobby: controller[5].text,
                            pass: controller[6].text,
                            context: context,
                            image: imageFile.value);
                        GoRouter.of(context)
                            .pushReplacementNamed(RouteName.homescreen);
                      }
                    },
                    child: const Text("Continue"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFiles({
    required String hintText,
    required int i,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
      child: TextFormField(
        validator: (value) {
          if (i == 4) {
            return null;
          }
          if (i == 6 && controller[6].text.length < 6) {
            return "Must contain more than 6 character";
          }

          return null;
        },
        controller: controller[i],
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
