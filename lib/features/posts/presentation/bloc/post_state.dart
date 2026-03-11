import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;
  final int currentSkip;

  const PostLoaded({
    required this.posts,
    required this.hasReachedMax,
    required this.currentSkip,
  });

  PostLoaded copyWith({
    List<Post>? posts,
    bool? hasReachedMax,
    int? currentSkip,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentSkip: currentSkip ?? this.currentSkip,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax, currentSkip];
}

class PostLoadingMore extends PostState {
  final List<Post> posts;
  final int currentSkip;

  const PostLoadingMore({
    required this.posts,
    required this.currentSkip,
  });

  @override
  List<Object> get props => [posts, currentSkip];
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}

class PostEmpty extends PostState {}
