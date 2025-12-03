import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../home/domain/book.dart';

part 'playlists_repository.g.dart';

class Playlist {
  final String id;
  final String name;
  final String? description;
  final bool isPublic;
  final List<Book> books;
  final DateTime createdAt;

  Playlist({
    required this.id,
    required this.name,
    this.description,
    this.isPublic = true,
    this.books = const [],
    required this.createdAt,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      isPublic: json['isPublic'] ?? true,
      books: (json['books'] as List?)
          ?.map((e) => Book.fromJson(e['book'] ?? e))
          .toList() ?? [],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }
}

class PlaylistsRepository {
  final Dio _dio;

  PlaylistsRepository(this._dio);

  Future<List<Playlist>> getPlaylists() async {
    try {
      final response = await _dio.get(ApiConstants.playlists);
      final List data = response.data is List ? response.data : [];
      return data.map((e) => Playlist.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load playlists: $e');
    }
  }

  Future<Playlist> getPlaylist(String id) async {
    try {
      final response = await _dio.get('${ApiConstants.playlists}/$id');
      return Playlist.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load playlist: $e');
    }
  }

  Future<Playlist> createPlaylist({
    required String name,
    String? description,
    bool isPublic = true,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.playlists,
        data: {
          'name': name,
          if (description != null) 'description': description,
          'isPublic': isPublic,
        },
      );
      return Playlist.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create playlist: $e');
    }
  }

  Future<void> deletePlaylist(String id) async {
    try {
      await _dio.delete('${ApiConstants.playlists}/$id');
    } catch (e) {
      throw Exception('Failed to delete playlist: $e');
    }
  }

  Future<void> addBookToPlaylist(String playlistId, String bookId) async {
    try {
      await _dio.post(
        '${ApiConstants.playlists}/$playlistId/books',
        data: {'bookId': bookId},
      );
    } catch (e) {
      throw Exception('Failed to add book to playlist: $e');
    }
  }

  Future<void> removeBookFromPlaylist(String playlistId, String bookId) async {
    try {
      await _dio.delete(
        '${ApiConstants.playlists}/$playlistId/books/$bookId',
      );
    } catch (e) {
      throw Exception('Failed to remove book from playlist: $e');
    }
  }
}

@Riverpod(keepAlive: true)
PlaylistsRepository playlistsRepository(Ref ref) {
  return PlaylistsRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<Playlist>> playlists(Ref ref) {
  return ref.watch(playlistsRepositoryProvider).getPlaylists();
}

@riverpod
Future<Playlist> playlistDetails(Ref ref, String id) {
  return ref.watch(playlistsRepositoryProvider).getPlaylist(id);
}
