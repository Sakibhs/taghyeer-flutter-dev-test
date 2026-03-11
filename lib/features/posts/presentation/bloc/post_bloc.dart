import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;
  static const int _pageSize = 10;

  PostBloc({required this.getPostsUseCase}) : super(PostInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<RefreshPosts>(_onRefreshPosts);
  }

  Future<void> _onLoadPosts(
    LoadPosts event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());

    final result = await getPostsUseCase(
      const GetPostsParams(limit: _pageSize, skip: 0),
    );

    result.fold(
      (failure) => emit(const PostError('Failed to load posts')),
      (response) {
        if (response.posts.isEmpty) {
          emit(PostEmpty());
        } else {
          emit(PostLoaded(
            posts: response.posts,
            hasReachedMax: response.posts.length >= response.total,
            currentSkip: _pageSize,
          ));
        }
      },
    );
  }

  Future<void> _onLoadMorePosts(
    LoadMorePosts event,
    Emitter<PostState> emit,
  ) async {
    final currentState = state;
    if (currentState is PostLoaded && !currentState.hasReachedMax) {
      emit(PostLoadingMore(
        posts: currentState.posts,
        currentSkip: currentState.currentSkip,
      ));

      final result = await getPostsUseCase(
        GetPostsParams(limit: _pageSize, skip: currentState.currentSkip),
      );

      result.fold(
        (failure) => emit(PostLoaded(
          posts: currentState.posts,
          hasReachedMax: currentState.hasReachedMax,
          currentSkip: currentState.currentSkip,
        )),
        (response) {
          final allPosts = List.of(currentState.posts)..addAll(response.posts);

          emit(PostLoaded(
            posts: allPosts,
            hasReachedMax: allPosts.length >= response.total,
            currentSkip: currentState.currentSkip + _pageSize,
          ));
        },
      );
    }
  }

  Future<void> _onRefreshPosts(
    RefreshPosts event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());

    final result = await getPostsUseCase(
      const GetPostsParams(limit: _pageSize, skip: 0),
    );

    result.fold(
      (failure) => emit(const PostError('Failed to refresh posts')),
      (response) {
        if (response.posts.isEmpty) {
          emit(PostEmpty());
        } else {
          emit(PostLoaded(
            posts: response.posts,
            hasReachedMax: response.posts.length >= response.total,
            currentSkip: _pageSize,
          ));
        }
      },
    );
  }
}
