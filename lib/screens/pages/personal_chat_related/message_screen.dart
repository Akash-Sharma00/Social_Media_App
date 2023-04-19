import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../const/allkeys.dart';
import '../../../main.dart';
import '../../../models/chat_message_model.dart';

class MessagesScreen extends StatefulWidget {
  final String? receiverid;
  final String? image;
  final String? roomid;
  final String? name;

  const MessagesScreen(
      {super.key,
      required this.receiverid,
      this.image,
      required this.roomid,
      required this.name});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late WebSocketChannel channel;
  @override
  void initState() {
    super.initState();
    // channel.sink.add("1234");
    channel = WebSocketChannel.connect(
      // Uri.parse('ws://192.168.0.103:9000/${widget.roomid}'),
      Uri.parse('ws://social-media-app-support.glitch.me/${widget.roomid}'),
    );

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     // reached the end of the scroll view
    //   }
    // });
  }

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/chat_bg.webp"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    List mapdata = [];
                    List<ChatMessageModel> model = [];

                    if (snapshot.hasData) {
                      if (scrollController.hasClients) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        );
                      }
                      var jsondata = jsonDecode(snapshot.data);
                      if (jsondata.length != 0) {
                        mapdata = jsondata[0]['chats'];
                        model = mapdata
                            .map<ChatMessageModel>(
                              (data) => ChatMessageModel.fromMap(data),
                            )
                            .toList();
                      }

                      return ListView.builder(
                          controller: scrollController,
                          itemCount: model.length,
                          itemBuilder: (context, index) {
                            // return ClipPath(
                            //   clipper: ChatBubbleClipperNoRadius(),

                            return ChatContainer(
                              model: model,
                              index: index,
                            );
                          });
                    } else {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Message",
                        fillColor: Colors.white,
                        filled: true,
                        focusColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      maxLines: 4,
                      minLines: 1,
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    child: IconButton(
                        onPressed: () {
                          if (controller.text.isEmpty) {
                            return;
                          }
                          Map updateDocument = {
                            "userid": prefs.getString(AllKeys.id),
                            "message": controller.text,
                            "file": "null",
                            "token": widget.roomid
                          };
                          var json = jsonEncode(updateDocument);
                          channel.sink.add(json);
                          controller.clear();
                        },
                        icon: const Icon(Icons.send)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.send),
      //   onPressed: () {
      //     Map updateDocument = {
      //       "userid": prefs.getString(AllKeys.id),
      //       "message": "hello",
      //       "file": "null",
      //       "token": widget.roomid
      //     };
      //     var json = jsonEncode(updateDocument);
      //     channel.sink.add(json);
      //   },
      // ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    super.key,
    required this.model,
    required this.index,
  });

  final List<ChatMessageModel> model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 5,
        left: model[index].userid == prefs.getString(AllKeys.id) ? 30 : 0,
        right: model[index].userid != prefs.getString(AllKeys.id) ? 30 : 2,
      ),
      padding: const EdgeInsets.only(left: 10),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
      alignment: model[index].userid == prefs.getString(AllKeys.id)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: model[index].userid == prefs.getString(AllKeys.id)
                ? Colors.green[800]
                : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: model[index].userid == prefs.getString(AllKeys.id)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                model[index].message!,
                style: TextStyle(
                  fontSize: 18,
                  color: model[index].userid == prefs.getString(AllKeys.id)
                      ? Colors.white
                      : Colors.black,
                ),
                softWrap: true,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              model[index].date!.substring(11, 16),
              style: TextStyle(
                fontSize: 13,
                color: model[index].userid == prefs.getString(AllKeys.id)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
          //   ),
        ),
      ),
    );
  }
}

class ChatBubbleClipperNoRadius extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 10;
    final width = size.width;
    final height = size.height;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(width - radius, 0);
    path.arcToPoint(Offset(width, radius),
        radius: const Radius.circular(radius));
    path.lineTo(width, height - radius);
    path.arcToPoint(Offset(width - radius, height),
        radius: const Radius.circular(radius));
    path.lineTo(radius + radius, height);
    path.arcToPoint(Offset(radius, height - radius),
        radius: const Radius.circular(radius));
    path.lineTo(radius, radius);
    path.close();
    // path.mo
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
