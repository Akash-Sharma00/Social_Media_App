// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/allblocs/userpostbloc/user_post_bloc.dart';
import 'package:social_media/common/my_widget.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:social_media/main.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<File?> imageFile = ValueNotifier(null);
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        // title: Text(prefs.getString(AllKeys.id) ?? "Akash"),
        actions: [
          TextButton(
            onPressed: () async {
              String? url;

              if (controller.text.isEmpty && imageFile.value == null) {
                mySnackBar(context, "Please enter text or image to post");
                return;
              }
              FirebaseStorage storage = FirebaseStorage.instance;

              Reference reference = storage.ref().child(
                  "posts/${prefs.getString(AllKeys.id)}${DateTime.now()}");
              if (imageFile.value != null) {
                await reference.putFile(imageFile.value!);
                url = await reference.getDownloadURL();
              }
              bool result = await createPost(
                  userid: prefs.getString(AllKeys.id) ?? "-1",
                  name: prefs.getString(AllKeys.name)!,
                  content: controller.text,
                  filelink: url ?? "",
                  userImage: prefs.getString(AllKeys.imagelink)!);
              if (result) {
                mySnackBar(context, "You posted successfuly");
                BlocProvider.of<UserPostBloc>(context)
                    .add(const UserPostEvent());
                    controller.clear();
                    imageFile.value = null;
              } else {
                mySnackBar(context, "Something went wrong");
              }
            },
            child: const Text(
              "Post",
              // style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Write something",
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
            GestureDetector(
              onTap: () async {
                imageFile.value = await pickPicture(context);
              },
              child: ValueListenableBuilder(
                builder: (context, imagedata, child) {
                  if (imagedata == null) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.transparent),
                      ),
                      child: Image.asset(
                        "assets/images/add_profiles.png",
                        height: 100,
                      ),
                    );
                  } else {
                    return Container(
                        margin: const EdgeInsets.only(top: 10),
                        constraints: const BoxConstraints(
                            maxWidth: double.infinity, maxHeight: 400),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 2, color: Colors.transparent),
                        ),
                        child: Image.file(imagedata));
                  }
                },
                valueListenable: imageFile,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: imageFile,
                builder: (context, val, child) {
                  return ElevatedButton(
                    onPressed: val == null
                        ? null
                        : () {
                            imageFile.value = null;
                          },
                    child: const Text("Remove image"),
                  );
                })
          ],
        ),
      ),
    );
  }
}
