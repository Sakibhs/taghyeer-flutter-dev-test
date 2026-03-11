import 'package:equatable/equatable.dart';
import 'post.dart';

class PostsResponse extends Equatable {
  final List<Post> posts;
  final int total;
  final int skip;
  final int limit;

  const PostsResponse({
    required this.posts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [posts, total, skip, limit];
}
