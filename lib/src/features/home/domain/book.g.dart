// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Book _$BookFromJson(Map<String, dynamic> json) => _Book(
  id: json['id'] as String,
  title: json['title'] as String,
  author: json['author'] as String,
  coverUrl: json['coverUrl'] as String?,
  cover: json['cover'] as String?,
  coverColor: json['coverColor'] as String?,
  uploader: json['uploader'] == null
      ? null
      : User.fromJson(json['uploader'] as Map<String, dynamic>),
  uploaderId: json['uploaderId'] as String?,
  views: (json['views'] as num?)?.toInt() ?? 0,
  timestamp: json['timestamp'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  fileUrl: json['fileUrl'] as String?,
  content: json['content'],
  type: json['type'] as String? ?? 'text',
);

Map<String, dynamic> _$BookToJson(_Book instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'author': instance.author,
  'coverUrl': instance.coverUrl,
  'cover': instance.cover,
  'coverColor': instance.coverColor,
  'uploader': instance.uploader,
  'uploaderId': instance.uploaderId,
  'views': instance.views,
  'timestamp': instance.timestamp,
  'createdAt': instance.createdAt?.toIso8601String(),
  'fileUrl': instance.fileUrl,
  'content': instance.content,
  'type': instance.type,
};
