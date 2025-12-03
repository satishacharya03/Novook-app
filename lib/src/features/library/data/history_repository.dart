import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../home/domain/book.dart';

part 'history_repository.g.dart';

class ReadingHistory {
  final String id;
  final String bookId;
  final Book book;
  final int progress;
  final DateTime lastRead;

  ReadingHistory({
    required this.id,
    required this.bookId,
    required this.book,
    required this.progress,
    required this.lastRead,
  });

  factory ReadingHistory.fromJson(Map<String, dynamic> json) {
    return ReadingHistory(
      id: json['id'] ?? '',
      bookId: json['bookId'] ?? '',
      book: Book.fromJson(json['book']),
      progress: json['progress'] ?? 0,
      lastRead: json['lastRead'] != null 
          ? DateTime.parse(json['lastRead']) 
          : DateTime.now(),
    );
  }
}

class HistoryRepository {
  final Dio _dio;

  HistoryRepository(this._dio);

  Future<List<ReadingHistory>> getHistory() async {
    try {
      final response = await _dio.get(ApiConstants.history);
      final List data = response.data is List ? response.data : [];
      return data.map((e) => ReadingHistory.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load history: $e');
    }
  }

  Future<void> updateProgress(String bookId, int progress) async {
    try {
      await _dio.post(
        ApiConstants.history,
        data: {
          'bookId': bookId,
          'progress': progress,
        },
      );
    } catch (e) {
      // Silently fail for progress updates
      print('Failed to update progress: $e');
    }
  }

  Future<int?> getProgress(String bookId) async {
    try {
      final history = await getHistory();
      final entry = history.where((h) => h.bookId == bookId).firstOrNull;
      return entry?.progress;
    } catch (e) {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
HistoryRepository historyRepository(Ref ref) {
  return HistoryRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<ReadingHistory>> readingHistory(Ref ref) {
  return ref.watch(historyRepositoryProvider).getHistory();
}
