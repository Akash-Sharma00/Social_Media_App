import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/models/comments_models.dart';
import 'package:social_media/repos/all_apis.dart';

part 'commets_event.dart';
part 'commets_state.dart';

class CommetsBloc extends Bloc<CommetsEvent, CommetsState> {
  CommetsBloc() : super(CommetsInitialState()) {
    on<CommentStartLoadingEvents>((event, emit) async {
      List<CommentModel> list =await Repositories().getPostCommetWithApi(event.postid);
      emit(CommetsLoadedState(comment: list));
    });
  }
}
