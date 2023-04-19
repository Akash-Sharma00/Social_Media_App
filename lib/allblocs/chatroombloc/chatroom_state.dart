part of 'chatroom_bloc.dart';

 class ChatroomState extends Equatable {
  const ChatroomState();
    @override
  List<Object> get props => [];

}

class ChatroomInitialState extends ChatroomState {
 
}
class ChatroomLoadingState extends ChatroomState {}
class ChatroomLoadedState extends ChatroomState {
  List<ChatRoomModel> model;
  ChatroomLoadedState({required this.model});
    @override
  List<Object> get props => [model];
}
class ChatroomErrorState extends ChatroomState {
  String error;
  ChatroomErrorState({required this.error});
    @override
  List<Object> get props => [error];
}
class ChatroomEmptyState extends ChatroomState {
  
    @override
  List<Object> get props => [];
}
