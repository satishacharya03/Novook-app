import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../domain/book.dart';

part 'book_repository.g.dart';

class BookRepository {
  final Dio _dio;

  BookRepository(this._dio);

  Future<List<Book>> getBooks() async {
    try {
      final response = await _dio.get(ApiConstants.books);
      print('Books API Response: ${response.data}');
      
      final List data = (response.data is List) 
          ? response.data 
          : (response.data['books'] ?? response.data['data'] ?? []);
      
      print('Extracted books list length: ${data.length}');
      
      final books = <Book>[];
      for (var i = 0; i < data.length; i++) {
        try {
          books.add(Book.fromJson(data[i]));
        } catch (e, stack) {
          print('Error parsing book at index $i: $e');
          print('Book data: ${data[i]}');
          print('Stack trace: $stack');
        }
      }
      
      print('Successfully parsed ${books.length} books');
      return books;
    } catch (e, stack) {
      print('Failed to load books: $e');
      print('Stack trace: $stack');
      throw Exception('Failed to load books: $e');
    }
  }

  Future<Book> getBookDetails(String id) async {
    try {
      final response = await _dio.get('${ApiConstants.books}/$id');
      return Book.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load book details: $e');
    }
  }

  Future<List<Book>> getTrendingBooks() async {
    try {
      final response = await _dio.get(ApiConstants.trending);
      final List data = (response.data is List) 
          ? response.data 
          : (response.data['books'] ?? response.data['data'] ?? []);
      return data.map((e) => Book.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load trending books: $e');
    }
  }
  
  Future<List<Book>> getRecommendedBooks() async {
    try {
      final response = await _dio.get(ApiConstants.recommended);
      final List data = (response.data is List) 
          ? response.data 
          : (response.data['books'] ?? response.data['data'] ?? []);
      return data.map((e) => Book.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load recommended books: $e');
    }
  }
}

@Riverpod(keepAlive: true)
BookRepository bookRepository(Ref ref) {
  return BookRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<Book>> books(Ref ref) {
  return ref.watch(bookRepositoryProvider).getBooks();
}

@riverpod
Future<Book> bookDetails(Ref ref, String id) {
  return ref.watch(bookRepositoryProvider).getBookDetails(id);
}

@riverpod
Future<List<Book>> trendingBooks(Ref ref) {
  return ref.watch(bookRepositoryProvider).getTrendingBooks();
}

@riverpod
Future<List<Book>> recommendedBooks(Ref ref) {
  return ref.watch(bookRepositoryProvider).getRecommendedBooks();
}
