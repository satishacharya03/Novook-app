// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String?,
  name: json['name'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
  image: json['image'] as String?,
  role: json['role'] as String? ?? 'USER',
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'email': instance.email,
  'image': instance.image,
  'role': instance.role,
};
