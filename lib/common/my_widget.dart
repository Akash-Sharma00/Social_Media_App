import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/const/all_const.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

mySnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
  ));
}

saveProfileInLocal({
  required String id,
  required String? name,
  required String number,
  required String username,
  required String description,
  required String mail,
  required String? imagelink,
  required String hobby,
}) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(AllKeys.id, id);
  prefs.setString(AllKeys.name, name ?? '');
  prefs.setString(AllKeys.email, mail);
  prefs.setString(AllKeys.number, number);
  prefs.setString(AllKeys.username, username);
  prefs.setString(AllKeys.imagelink, imagelink ?? AllConst.defaultProfileLink);
  prefs.setString(AllKeys.description, description);
  prefs.setString(AllKeys.hobby, hobby);
  print("123456789$id");
}

Future pickPicture(BuildContext context) async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imagePath = File(image.path);
    return imagePath;
  } on PlatformException catch (e) {
    mySnackBar(context, e.toString());
    return null;
  }
}

createPost({
  required String userid,
  required String name,
  required String content,
  required String? filelink,
  required String userImage,
}) async {
  String link = "https://scial-media-backend.vercel.app/createpost";
  Map model = {
    "id": const Uuid().v1(),
    "name": name,
    "content": content,
    "fileLink": filelink,
    "UserImage": userImage,
    "userID": userid
  };
  Response response = await Dio().post(link, data: model);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

addCommentd({
  required String postid,
  required String name,
  required String content,
  required String userImage,
}) async {
  String link = "https://scial-media-backend.vercel.app/addcomments/$postid";
  Map model = {
    "id": const Uuid().v1(),
    "username": name,
    "content": content,
    "userImage": userImage,
  };
  Response response = await Dio().post(link, data: model);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
