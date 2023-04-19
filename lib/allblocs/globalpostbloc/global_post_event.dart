part of 'global_post_bloc.dart';

class GlobalPostEvent extends Equatable {
  const GlobalPostEvent();

  @override
  List<Object> get props => [];
}

class GlobalPostLoadedEvents extends GlobalPostEvent {}

class GlobalPostErrorEvent extends GlobalPostEvent {}
