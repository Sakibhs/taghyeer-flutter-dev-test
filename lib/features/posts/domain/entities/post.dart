import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final int userId;
  final List<String>? tags;
  final Map<String, dynamic>? reactions;

  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    this.tags,
    this.reactions,
  });

  int get totalReactions {
    if (reactions == null) return 0;
    int total = 0;
    reactions!.forEach((key, value) {
      if (value is int) total += value;
    });
    return total;
  }

  @override
  List<Object?> get props => [id, title, body, userId, tags, reactions];
}
