import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/models/chat_room_model.dart';
import 'package:social_media/repos/all_apis.dart';

part 'chatroom_event.dart';
part 'chatroom_state.dart';

class ChatroomBloc extends Bloc<ChatroomEvent, ChatroomState> {
  ChatroomBloc() : super(const ChatroomState()) {
    on<LoadChatRoomEvent>((event, emit) async {
      emit(ChatroomLoadingState());
      List<ChatRoomModel> modeldata = await Repositories().getConnectedChats();
      if(modeldata.isEmpty){
        emit(ChatroomEmptyState());
      }else{

      emit(ChatroomLoadedState(model: modeldata));
      }
    });
  }
}
