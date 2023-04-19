import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/models/profile_model.dart';
import 'package:social_media/repos/all_apis.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  GetProfileBloc() : super(GetProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      ProfileModel model = await Repositories().getProfileDataFromLocal();

      emit(ProfileLoaded(profileModel: model));
    });
  }
}
