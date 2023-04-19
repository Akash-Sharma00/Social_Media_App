import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/allblocs/chatroombloc/chatroom_bloc.dart';
import 'package:social_media/allblocs/commentbloc/commets_bloc.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:social_media/main.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repos/all_apis.dart';
import 'package:social_media/screens/home_screen.dart';

import '../models/comments_models.dart';
import 'comments_pages.dart';

class UiCommons {
  static postCard(
      {required PostModel model,
      required bool likeClick,
      required BuildContext context}) {
    ValueNotifier<int> likes = ValueNotifier(model.likeCount);
    Icon heart = const Icon(
      Icons.favorite,
      color: Colors.red,
    );
    bool isLiked = false;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: likeClick
                  ? () {
                      // GoRouter.of(context).pushNamed(
                      //     RouteName.searchuserprofilescreen,
                      //     extra: model.userID);
                    }
                  : null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.UserImage,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        "assets/images/add_profiles.png",
                        width: 40,
                        height: 40,
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 100),
                            child: Text(
                              " ${model.name!} ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "@${model.userID}".substring(0, 15),
                            style: const TextStyle(color: Colors.blue),
                            maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Text(
                        "${model.date!.substring(0, 10)} at ${model.date!.substring(11, 16)}",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.adaptive.more,
                      color: Colors.black,
                    ),
                    color: Colors.white,
                    onSelected: (value) async {
                      await Repositories().createChatRoom(
                          userid: prefs.getString(AllKeys.id) ?? "",
                          connectionid: model.userID!,
                          image: model.UserImage,
                          localimage: prefs.getString(AllKeys.imagelink));
                      currentIndex.value = 2;
                      BlocProvider.of<ChatroomBloc>(context)
                          .add(LoadChatRoomEvent());
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Message'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(
                            choice,
                            style: const TextStyle(),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              model.content!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Visibility(
            visible: model.fileLink!.isNotEmpty,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                constraints: const BoxConstraints(
                    maxWidth: double.infinity, maxHeight: 400),
                child: Image.network(
                  model.fileLink!,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ValueListenableBuilder(
                  valueListenable: likes,
                  builder: (context, val, chils) {
                    return Row(
                      children: [
                        Text("${likes.value}"),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: likeClick
                                ? () async {
                                    if (!isLiked) {
                                      isLiked = true;
                                      likes.value++;
                                      await Dio().get(
                                          "https://scial-media-backend.vercel.app/like/${model.id}");
                                    } else {
                                      isLiked = false;
                                      likes.value--;
                                      await Dio().get(
                                          "https://scial-media-backend.vercel.app/unlike/${model.id}");
                                    }
                                  }
                                : null,
                            icon: likeClick
                                ? isLiked
                                    ? heart
                                    : const Icon(
                                        Icons.favorite_border_outlined,
                                      )
                                : heart),
                      ],
                    );
                  }),
              IconButton(
                onPressed: () {
                  BlocProvider.of<CommetsBloc>(context)
                      .add(CommentStartLoadingEvents(postid: model.id ?? ""));
                  bottomSheet(context, model);
                },
                icon: const FaIcon(FontAwesomeIcons.comment),
              ),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.shareFromSquare),
              ),
            ],
          )
        ],
      ),
    );
  }

  static commentCard(CommentModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: model.userImage,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      "assets/images/add_profiles.png",
                      width: 40,
                      height: 40,
                    );
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            model.username,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Text(
                        //   model.i,
                        //   style: const TextStyle(color: Colors.blue),
                        // ),
                      ],
                    ),
                    Text(
                      "${model.date.substring(0, 10)} at ${model.date.substring(11, 16)}",
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.start,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(model.content),
          ),
        ],
      ),
    );
  }
}
