import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/all_routes/routes_const.dart';
import 'package:social_media/models/chat_room_model.dart';

class UserCard extends StatelessWidget {
  final ChatRoomModel model;
  const UserCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .pushNamed(RouteName.personalmessagescreen, queryParams: {
          'name': model.name,
          'receiverid': model.conecteid,
          'roomid': model.roomid,
          'image': model.image ?? ""
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            CachedNetworkImage(
                imageUrl: model.image ?? "",
                imageBuilder: (context, imageProvider) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    "assets/images/add_profiles.png",
                    width: 60,
                    height: 60,
                  );
                }),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.name),
                      Text(model.time ?? "NA"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(model.lastmessage ?? "No messages")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
