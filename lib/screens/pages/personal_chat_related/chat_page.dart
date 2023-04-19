import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/screens/pages/personal_chat_related/user_card.dart';

import '../../../allblocs/chatroombloc/chatroom_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: BlocBuilder<ChatroomBloc, ChatroomState>(
        builder: (context, state) {
          if (state is ChatroomLoadedState) {
            return ListView.builder(
                itemCount: state.model.length,
                itemBuilder: (context, index) =>
                    UserCard(model: state.model[index]));
          } else if (state is ChatroomEmptyState) {
            return const Center(child: Text("Add Someone to the chat"));
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}
