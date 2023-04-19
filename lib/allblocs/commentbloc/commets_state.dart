part of 'commets_bloc.dart';

abstract class CommetsState extends Equatable {
  const CommetsState();

  @override
  List<Object> get props => [];
}

class CommetsInitialState extends CommetsState {}

class CommetsLoadedState extends CommetsState {
  List<CommentModel> comment;
  CommetsLoadedState({required this.comment});
  @override
  List<Object> get props => [comment];
}

class CommetsErrorState extends CommetsState {
  String error;
  CommetsErrorState({required this.error});
  @override
  List<Object> get props => [];
}
