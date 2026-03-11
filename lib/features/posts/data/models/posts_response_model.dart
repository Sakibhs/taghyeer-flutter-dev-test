import '../../domain/entities/posts_response.dart';
import 'post_model.dart';

class PostsResponseModel extends PostsResponse {
  const PostsResponseModel({
    required super.posts,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory PostsResponseModel.fromJson(Map<String, dynamic> json) {
    return PostsResponseModel(
      posts: (json['posts'] as List)
          .map((post) => PostModel.fromJson(post as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posts': posts.map((p) => (p as PostModel).toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}
