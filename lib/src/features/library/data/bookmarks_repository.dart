import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../home/domain/book.dart';

part 'bookmarks_repository.g.dart';

class Bookmark {
  final String id;
  final String bookId;
  final Book book;
  final DateTime createdAt;

  Bookmark({
    required this.id,
    required this.bookId,
    required this.book,
    required this.createdAt,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] ?? '',
      bookId: json['bookId'] ?? '',
      book: Book.fromJson(json['book']),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }
}

class BookmarksRepository {
  final Dio _dio;

  BookmarksRepository(this._dio);

  Future<List<Bookmark>> getBookmarks() async {
    try {
      final response = await _dio.get(ApiConstants.bookmarks);
      final List data = response.data is List ? response.data : [];
      return data.map((e) => Bookmark.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load bookmarks: $e');
    }
  }

  Future<bool> toggleBookmark(String bookId) async {
    try {
      final response = await _dio.post(
        ApiConstants.bookmarks,
        data: {'bookId': bookId},
      );
      return response.data['bookmarked'] ?? false;
    } catch (e) {
      throw Exception('Failed to toggle bookmark: $e');
    }
  }

  Future<bool> isBookmarked(String bookId) async {
    try {
      final bookmarks = await getBookmarks();
      return bookmarks.any((b) => b.bookId == bookId);
    } catch (e) {
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
BookmarksRepository bookmarksRepository(Ref ref) {
  return BookmarksRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<Bookmark>> bookmarks(Ref ref) {
  return ref.watch(bookmarksRepositoryProvider).getBookmarks();
}

@riverpod
class BookmarkState extends _$BookmarkState {
  @override
  Future<Set<String>> build() async {
    try {
      final bookmarks = await ref.watch(bookmarksRepositoryProvider).getBookmarks();
      return bookmarks.map((b) => b.bookId).toSet();
    } catch (e) {
      return {};
    }
  }

  Future<void> toggleBookmark(String bookId) async {
    final repo = ref.read(bookmarksRepositoryProvider);
    try {
      final isNowBookmarked = await repo.toggleBookmark(bookId);
      final currentSet = state.value ?? {};
      if (isNowBookmarked) {
        state = AsyncValue.data({...currentSet, bookId});
      } else {
        state = AsyncValue.data(currentSet.where((id) => id != bookId).toSet());
      }
    } catch (e) {
      // Handle error
    }
  }

  bool isBookmarked(String bookId) {
    return state.value?.contains(bookId) ?? false;
  }
}
