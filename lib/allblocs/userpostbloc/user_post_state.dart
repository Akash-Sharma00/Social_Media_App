// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'user_post_bloc.dart';

abstract class UserPostState extends Equatable {
  const UserPostState();
  
}

class UserPostInitial extends UserPostState {
  
  @override
  List<Object> get props => [];
}
class UserPostLoadedState extends UserPostState {
  List<PostModel> model;
  UserPostLoadedState({required this.model});
  @override
  List<Object> get props => model;
}
class UserPostErrorState extends UserPostState {
  String error;
  UserPostErrorState({
    required this.error,
  });
  
  @override
  List<Object> get props => [error];
}

