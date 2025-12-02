import 'package:freezed_annotation/freezed_annotation.dart';
import '../../auth/domain/user.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
abstract class Book with _$Book {
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
    dynamic content, // String or other content
    @Default('text') String type, // 'pdf' or 'text'
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) {
    // Detect type from fileUrl if not provided
    String type = json['type'] as String? ?? 'text';
    if (type == 'text' && json['fileUrl'] != null) {
      final fileUrl = json['fileUrl'] as String;
      if (fileUrl.toLowerCase().endsWith('.pdf')) {
        type = 'pdf';
      }
    }
    
    // Add the inferred type to the json
    final jsonWithType = Map<String, dynamic>.from(json);
    jsonWithType['type'] = type;
    
    return _$BookFromJson(jsonWithType);
  }
}
