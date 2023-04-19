part of 'chatroom_bloc.dart';

abstract class ChatroomEvent extends Equatable {
  const ChatroomEvent();

  @override
  List<Object> get props => [];
}

class LoadChatRoomEvent extends ChatroomEvent{}
