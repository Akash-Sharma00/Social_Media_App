import 'package:flutter/material.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:social_media/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.0.103:9000/${prefs.getString(AllKeys.id)}'),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // channel.sink.add("1234");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Demo'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data['chats'].toString());
            } else {
              return Text("${snapshot.data['chats']}");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () {
          channel.sink.add("Hero");
        },
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
