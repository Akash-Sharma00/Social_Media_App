// ignore_for_file: must_be_immutable

part of 'global_post_bloc.dart';

abstract class GlobalPostState extends Equatable {
  const GlobalPostState();
}

class GlobalPostInitial extends GlobalPostState {
  @override
  List<Object> get props => [];
}

class GlobalPostLoadedState extends GlobalPostInitial {
  List<PostModel> model;
  GlobalPostLoadedState({required this.model});
  @override
  List<Object> get props => model;
}

class GlobalPostErrorState extends GlobalPostInitial {
  String error;
  GlobalPostErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
