import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../home/domain/book.dart';

part 'search_repository.g.dart';

class SearchRepository {
  final Dio _dio;

  SearchRepository(this._dio);

  Future<List<Book>> search({
    String? query,
    String? genre,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      if (query != null && query.isNotEmpty) {
        params['q'] = query;
      }
      if (genre != null && genre.isNotEmpty) {
        params['genre'] = genre;
      }

      final response = await _dio.get(
        ApiConstants.search,
        queryParameters: params,
      );

      final List data = response.data is List 
          ? response.data 
          : (response.data['books'] ?? []);

      return data.map((e) => Book.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }
}

@Riverpod(keepAlive: true)
SearchRepository searchRepository(Ref ref) {
  return SearchRepository(ref.watch(apiClientProvider));
}

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
class SearchGenre extends _$SearchGenre {
  @override
  String? build() => null;

  void setGenre(String? genre) {
    state = genre;
  }
}

@riverpod
Future<List<Book>> searchResults(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  final genre = ref.watch(searchGenreProvider);
  
  if (query.isEmpty && genre == null) {
    return [];
  }

  return ref.watch(searchRepositoryProvider).search(
    query: query.isEmpty ? null : query,
    genre: genre,
  );
}
