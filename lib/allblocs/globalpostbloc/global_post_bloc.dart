import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';
import '../../repos/all_apis.dart';

part 'global_post_event.dart';
part 'global_post_state.dart';

class GlobalPostBloc extends Bloc<GlobalPostEvent, GlobalPostState> {
  GlobalPostBloc() : super(GlobalPostInitial()) {
    on<GlobalPostEvent>((event, emit) async {
      List<PostModel> model = await Repositories().getGlobalpostWithApi();
      emit(GlobalPostLoadedState(model: model));
    });
  }
}
