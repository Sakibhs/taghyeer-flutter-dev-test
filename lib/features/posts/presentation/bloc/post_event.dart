import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends PostEvent {
  const LoadPosts();
}

class LoadMorePosts extends PostEvent {
  const LoadMorePosts();
}

class RefreshPosts extends PostEvent {
  const RefreshPosts();
}
