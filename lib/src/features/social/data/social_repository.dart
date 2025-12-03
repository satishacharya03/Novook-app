import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';

part 'social_repository.g.dart';

class SocialRepository {
  final Dio _dio;

  SocialRepository(this._dio);

  // Likes
  Future<bool> toggleLike(String bookId) async {
    try {
      final response = await _dio.post(
        ApiConstants.likes,
        data: {'bookId': bookId},
      );
      return response.data['liked'] ?? false;
    } catch (e) {
      throw Exception('Failed to toggle like: $e');
    }
  }

  // Follow
  Future<bool> toggleFollow(String targetUserId) async {
    try {
      final response = await _dio.post(
        ApiConstants.follow,
        data: {'targetUserId': targetUserId},
      );
      return response.data['following'] ?? false;
    } catch (e) {
      throw Exception('Failed to toggle follow: $e');
    }
  }

  // Comments
  Future<List<Comment>> getComments(String bookId) async {
    try {
      final response = await _dio.get(
        ApiConstants.comments,
        queryParameters: {'bookId': bookId},
      );
      final List data = response.data is List ? response.data : [];
      return data.map((e) => Comment.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  Future<Comment> addComment(String bookId, String content, {String? parentId}) async {
    try {
      final response = await _dio.post(
        ApiConstants.comments,
        data: {
          'bookId': bookId,
          'content': content,
          if (parentId != null) 'parentId': parentId,
        },
      );
      return Comment.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }
}

class Comment {
  final String id;
  final String content;
  final String userId;
  final String? userName;
  final String? userImage;
  final DateTime createdAt;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    this.userName,
    this.userImage,
    required this.createdAt,
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['user']?['name'],
      userImage: json['user']?['image'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      replies: (json['replies'] as List?)
          ?.map((e) => Comment.fromJson(e))
          .toList() ?? [],
    );
  }
}

@Riverpod(keepAlive: true)
SocialRepository socialRepository(Ref ref) {
  return SocialRepository(ref.watch(apiClientProvider));
}

@riverpod
class LikeState extends _$LikeState {
  @override
  Set<String> build() => {};

  Future<void> toggleLike(String bookId) async {
    final repo = ref.read(socialRepositoryProvider);
    try {
      final isNowLiked = await repo.toggleLike(bookId);
      if (isNowLiked) {
        state = {...state, bookId};
      } else {
        state = state.where((id) => id != bookId).toSet();
      }
    } catch (e) {
      // Handle error
    }
  }

  bool isLiked(String bookId) => state.contains(bookId);
}

@riverpod
class FollowState extends _$FollowState {
  @override
  Set<String> build() => {};

  Future<void> toggleFollow(String userId) async {
    final repo = ref.read(socialRepositoryProvider);
    try {
      final isNowFollowing = await repo.toggleFollow(userId);
      if (isNowFollowing) {
        state = {...state, userId};
      } else {
        state = state.where((id) => id != userId).toSet();
      }
    } catch (e) {
      // Handle error
    }
  }

  bool isFollowing(String userId) => state.contains(userId);
}

@riverpod
Future<List<Comment>> bookComments(Ref ref, String bookId) {
  return ref.watch(socialRepositoryProvider).getComments(bookId);
}
