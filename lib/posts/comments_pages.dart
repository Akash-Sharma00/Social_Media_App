import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:social_media/main.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/posts/ui_commons.dart';

import '../allblocs/commentbloc/commets_bloc.dart';
import '../common/my_widget.dart';

bottomSheet(BuildContext context, PostModel post) {
  TextEditingController controller = TextEditingController();

  return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
            heightFactor: 0.75,
            child: BlocBuilder<CommetsBloc, CommetsState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("All Comments"),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            width: 330,
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.grey,
                                  hintText: "Add a comment..."),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (controller.text.isNotEmpty) {
                                bool result = await addCommentd(
                                    postid: post.id ?? "",
                                    name: prefs.getString(AllKeys.name) ?? "",
                                    content: controller.text,
                                    userImage:
                                        prefs.getString(AllKeys.imagelink) ??
                                            "");
                                if (result) {
                                  BlocProvider.of<CommetsBloc>(context).add(
                                      CommentStartLoadingEvents(
                                          postid: post.id ?? ""));
                                }
                                controller.clear();
                              } else {
                                mySnackBar(
                                    context, "Write something to comments");
                              }
                            },
                            icon: const FaIcon(FontAwesomeIcons.share))
                      ],
                    ),
                    state is CommetsLoadedState
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: state.comment.length,
                                itemBuilder: (context, index) {
                                  return UiCommons.commentCard(
                                      state.comment[index]);
                                }),
                          )
                        : const Center(
                            child: CircularProgressIndicator.adaptive())
                  ],
                );
              },
            ));
      });
}
