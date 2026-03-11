import 'package:equatable/equatable.dart';

abstract class PostDetailEvent extends Equatable {
  const PostDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadPostDetail extends PostDetailEvent {
  final int postId;

  const LoadPostDetail(this.postId);

  @override
  List<Object> get props => [postId];
}
