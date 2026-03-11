import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_post_detail_usecase.dart';
import 'post_detail_event.dart';
import 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final GetPostDetailUseCase getPostDetailUseCase;

  PostDetailBloc({required this.getPostDetailUseCase})
      : super(PostDetailInitial()) {
    on<LoadPostDetail>(_onLoadPostDetail);
  }

  Future<void> _onLoadPostDetail(
    LoadPostDetail event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(PostDetailLoading());

    final result = await getPostDetailUseCase(event.postId);

    result.fold(
      (failure) => emit(const PostDetailError('Failed to load post details')),
      (post) => emit(PostDetailLoaded(post)),
    );
  }
}
