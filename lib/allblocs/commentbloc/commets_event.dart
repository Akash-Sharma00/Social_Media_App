part of 'commets_bloc.dart';

abstract class CommetsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentStartLoadingEvents extends CommetsEvent {
  String postid;
  CommentStartLoadingEvents({required this.postid});
  @override
  List<Object> get props => [postid];
}
