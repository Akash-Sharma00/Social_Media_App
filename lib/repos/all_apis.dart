import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/common/my_widget.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:social_media/main.dart';
import 'package:social_media/models/chat_room_model.dart';
import 'package:social_media/models/comments_models.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/models/profile_model.dart';

class Repositories {
  addUser({
    required String id,
    required String? name,
    required String number,
    required String username,
    required String description,
    required String mail,
    String? imagelink,
    required String hobby,
  }) async {
    String link = "https://scial-media-backend.vercel.app/adduser";
    await saveProfileInLocal(
        id: id,
        name: name,
        number: number,
        username: username,
        description: description,
        mail: mail,
        imagelink: imagelink,
        hobby: hobby);
    await Dio().post(link, data: {
      "id": id,
      "name": name,
      "email": mail,
      "username": username,
      "number": number,
      "description": description,
      "imagelink": imagelink,
      "hobby": hobby
    });
  }

  getUserDataWithApi({required String userId}) async {
    String link = "https://scial-media-backend.vercel.app/getuser/$userId";
    Response response = await Dio().get(link);
    if (response.statusCode == 200) {
      return response.data[0];
    } else {
      return [];
    }
  }

  Future<List<PostModel>> getUserpostWithApi({required String userId}) async {
    String link = "https://scial-media-backend.vercel.app/getpost/$userId";
    Response response = await Dio().get(link);
    if (response.statusCode == 200) {
      final data1 = response.data;
      List<PostModel> model;
      model = data1.map<PostModel>((data) => PostModel.fromMap(data)).toList();
      return model;
    } else {
      return [];
    }
  }

  Future<List<PostModel>> getGlobalpostWithApi() async {
    String link = "https://scial-media-backend.vercel.app/getallpost";
    Response response = await Dio().get(link);
    if (response.statusCode == 200) {
      final data1 = response.data;
      List<PostModel> model;
      model = data1.map<PostModel>((data) => PostModel.fromMap(data)).toList();
      return model;
    } else {
      return [];
    }
  }

  Future<List<CommentModel>> getPostCommetWithApi(String id) async {
    String link = "https://scial-media-backend.vercel.app/getcomments/$id";
    Response response = await Dio().get(link);
    if (response.statusCode == 200) {
      if (response.data.isEmpty) {
        return [];
      }
      final data1 = response.data[0]['comment'];
      List<CommentModel> model;
      model = data1
          .map<CommentModel>((data) => CommentModel.fromMap(data))
          .toList();
      return model;
    } else {
      return [];
    }
  }

  Future<ProfileModel> getProfileDataFromLocal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString(AllKeys.name);
    if (id == null) {
      FirebaseAuth auth = FirebaseAuth.instance;
      ProfileModel model = ProfileModel.fromMap(
          await getUserDataWithApi(userId: auth.currentUser!.uid));
      return model;
    } else {
      ProfileModel model = ProfileModel(
          id: id,
          name: pref.getString(AllKeys.name),
          description: pref.getString(AllKeys.description),
          email: pref.getString(AllKeys.email),
          hobby: pref.getString(AllKeys.hobby),
          imagelink: pref.getString(AllKeys.imagelink),
          number: pref.getString(AllKeys.number),
          username: pref.getString(AllKeys.username));
      return model;
    }
  }

  Future<bool> createChatRoom({
    required String userid,
    required String connectionid,
    required String? image,
    required String? localimage,
  }) async {
    String link =
        "https://scial-media-backend-git-master-akash-sharma00.vercel.app/startchat/$userid/$connectionid";
    await Dio().get(link);
    return true;
  }

  Future<List<ChatRoomModel>> getConnectedChats() async {
    String id = prefs.getString(AllKeys.id) ?? "Akash";
    String link = "https://scial-media-backend.vercel.app/getchatroom/$id";
    Response response = await Dio().get(link);
    if (response.statusCode == 200) {
      if (response.data.isEmpty) {
        return [];
      }
      log(link);
      final List data1 = response.data[0]["connectedIds"] ?? [];

      List<ChatRoomModel> model;
      model = data1
          .map<ChatRoomModel>((data) => ChatRoomModel.fromMap(data))
          .toList();
      return model;
    } else {
      return [];
    }
  }
}
