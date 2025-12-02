// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Book {

 String get id; String get title; String get author; String? get coverUrl; String? get cover; String? get coverColor; User? get uploader; String? get uploaderId; int get views; String? get timestamp; DateTime? get createdAt; String? get fileUrl; dynamic get content;// String or other content
 String get type;
/// Create a copy of Book
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookCopyWith<Book> get copyWith => _$BookCopyWithImpl<Book>(this as Book, _$identity);

  /// Serializes this Book to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Book&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.coverColor, coverColor) || other.coverColor == coverColor)&&(identical(other.uploader, uploader) || other.uploader == uploader)&&(identical(other.uploaderId, uploaderId) || other.uploaderId == uploaderId)&&(identical(other.views, views) || other.views == views)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,coverUrl,cover,coverColor,uploader,uploaderId,views,timestamp,createdAt,fileUrl,const DeepCollectionEquality().hash(content),type);

@override
String toString() {
  return 'Book(id: $id, title: $title, author: $author, coverUrl: $coverUrl, cover: $cover, coverColor: $coverColor, uploader: $uploader, uploaderId: $uploaderId, views: $views, timestamp: $timestamp, createdAt: $createdAt, fileUrl: $fileUrl, content: $content, type: $type)';
}


}

/// @nodoc
abstract mixin class $BookCopyWith<$Res>  {
  factory $BookCopyWith(Book value, $Res Function(Book) _then) = _$BookCopyWithImpl;
@useResult
$Res call({
 String id, String title, String author, String? coverUrl, String? cover, String? coverColor, User? uploader, String? uploaderId, int views, String? timestamp, DateTime? createdAt, String? fileUrl, dynamic content, String type
});


$UserCopyWith<$Res>? get uploader;

}
/// @nodoc
class _$BookCopyWithImpl<$Res>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._self, this._then);

  final Book _self;
  final $Res Function(Book) _then;

/// Create a copy of Book
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? author = null,Object? coverUrl = freezed,Object? cover = freezed,Object? coverColor = freezed,Object? uploader = freezed,Object? uploaderId = freezed,Object? views = null,Object? timestamp = freezed,Object? createdAt = freezed,Object? fileUrl = freezed,Object? content = freezed,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,coverColor: freezed == coverColor ? _self.coverColor : coverColor // ignore: cast_nullable_to_non_nullable
as String?,uploader: freezed == uploader ? _self.uploader : uploader // ignore: cast_nullable_to_non_nullable
as User?,uploaderId: freezed == uploaderId ? _self.uploaderId : uploaderId // ignore: cast_nullable_to_non_nullable
as String?,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as dynamic,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of Book
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get uploader {
    if (_self.uploader == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.uploader!, (value) {
    return _then(_self.copyWith(uploader: value));
  });
}
}


/// Adds pattern-matching-related methods to [Book].
extension BookPatterns on Book {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Book value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Book() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Book value)  $default,){
final _that = this;
switch (_that) {
case _Book():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Book value)?  $default,){
final _that = this;
switch (_that) {
case _Book() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String author,  String? coverUrl,  String? cover,  String? coverColor,  User? uploader,  String? uploaderId,  int views,  String? timestamp,  DateTime? createdAt,  String? fileUrl,  dynamic content,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Book() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.coverUrl,_that.cover,_that.coverColor,_that.uploader,_that.uploaderId,_that.views,_that.timestamp,_that.createdAt,_that.fileUrl,_that.content,_that.type);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String author,  String? coverUrl,  String? cover,  String? coverColor,  User? uploader,  String? uploaderId,  int views,  String? timestamp,  DateTime? createdAt,  String? fileUrl,  dynamic content,  String type)  $default,) {final _that = this;
switch (_that) {
case _Book():
return $default(_that.id,_that.title,_that.author,_that.coverUrl,_that.cover,_that.coverColor,_that.uploader,_that.uploaderId,_that.views,_that.timestamp,_that.createdAt,_that.fileUrl,_that.content,_that.type);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String author,  String? coverUrl,  String? cover,  String? coverColor,  User? uploader,  String? uploaderId,  int views,  String? timestamp,  DateTime? createdAt,  String? fileUrl,  dynamic content,  String type)?  $default,) {final _that = this;
switch (_that) {
case _Book() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.coverUrl,_that.cover,_that.coverColor,_that.uploader,_that.uploaderId,_that.views,_that.timestamp,_that.createdAt,_that.fileUrl,_that.content,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Book implements Book {
  const _Book({required this.id, required this.title, required this.author, this.coverUrl, this.cover, this.coverColor, this.uploader, this.uploaderId, this.views = 0, this.timestamp, this.createdAt, this.fileUrl, this.content, this.type = 'text'});
  factory _Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

@override final  String id;
@override final  String title;
@override final  String author;
@override final  String? coverUrl;
@override final  String? cover;
@override final  String? coverColor;
@override final  User? uploader;
@override final  String? uploaderId;
@override@JsonKey() final  int views;
@override final  String? timestamp;
@override final  DateTime? createdAt;
@override final  String? fileUrl;
@override final  dynamic content;
// String or other content
@override@JsonKey() final  String type;

/// Create a copy of Book
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookCopyWith<_Book> get copyWith => __$BookCopyWithImpl<_Book>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Book&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.coverColor, coverColor) || other.coverColor == coverColor)&&(identical(other.uploader, uploader) || other.uploader == uploader)&&(identical(other.uploaderId, uploaderId) || other.uploaderId == uploaderId)&&(identical(other.views, views) || other.views == views)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,coverUrl,cover,coverColor,uploader,uploaderId,views,timestamp,createdAt,fileUrl,const DeepCollectionEquality().hash(content),type);

@override
String toString() {
  return 'Book(id: $id, title: $title, author: $author, coverUrl: $coverUrl, cover: $cover, coverColor: $coverColor, uploader: $uploader, uploaderId: $uploaderId, views: $views, timestamp: $timestamp, createdAt: $createdAt, fileUrl: $fileUrl, content: $content, type: $type)';
}


}

/// @nodoc
abstract mixin class _$BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$BookCopyWith(_Book value, $Res Function(_Book) _then) = __$BookCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String author, String? coverUrl, String? cover, String? coverColor, User? uploader, String? uploaderId, int views, String? timestamp, DateTime? createdAt, String? fileUrl, dynamic content, String type
});


@override $UserCopyWith<$Res>? get uploader;

}
/// @nodoc
class __$BookCopyWithImpl<$Res>
    implements _$BookCopyWith<$Res> {
  __$BookCopyWithImpl(this._self, this._then);

  final _Book _self;
  final $Res Function(_Book) _then;

/// Create a copy of Book
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? author = null,Object? coverUrl = freezed,Object? cover = freezed,Object? coverColor = freezed,Object? uploader = freezed,Object? uploaderId = freezed,Object? views = null,Object? timestamp = freezed,Object? createdAt = freezed,Object? fileUrl = freezed,Object? content = freezed,Object? type = null,}) {
  return _then(_Book(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,coverColor: freezed == coverColor ? _self.coverColor : coverColor // ignore: cast_nullable_to_non_nullable
as String?,uploader: freezed == uploader ? _self.uploader : uploader // ignore: cast_nullable_to_non_nullable
as User?,uploaderId: freezed == uploaderId ? _self.uploaderId : uploaderId // ignore: cast_nullable_to_non_nullable
as String?,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as dynamic,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of Book
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get uploader {
    if (_self.uploader == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.uploader!, (value) {
    return _then(_self.copyWith(uploader: value));
  });
}
}

// dart format on
