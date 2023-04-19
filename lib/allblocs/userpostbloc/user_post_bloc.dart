import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/const/allkeys.dart';
import 'package:social_media/models/post_model.dart';
import 'package:social_media/repos/all_apis.dart';

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  UserPostBloc() : super(UserPostInitial()) {
    on<UserPostEvent>((event, emit)async {
      SharedPreferences prefs =await SharedPreferences.getInstance();
      String? id = prefs.getString(AllKeys.id);
      List<PostModel> model =await Repositories().getUserpostWithApi(userId: id!);
      emit(UserPostLoadedState(model: model));
    });
  }
}
