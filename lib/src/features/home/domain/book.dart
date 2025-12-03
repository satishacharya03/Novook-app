import 'package:freezed_annotation/freezed_annotation.dart';
import '../../auth/domain/user.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
sealed class Book with _$Book {
  // Fields:
  // - content: Can be String or other content types
  // - type: Either 'pdf' or 'text'
  
  const factory Book({
    required String id,
    required String title,
    required String author,
    String? coverUrl,
    String? cover,
    String? coverColor,
    User? uploader,
    String? uploaderId,
    @Default(0) int views,
    String? timestamp,
    DateTime? createdAt,
    String? fileUrl,
    dynamic content,
    @Default('text') String type,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
