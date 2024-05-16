// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      secondName: json['secondName'] as String?,
      firstLastName: json['firstLastName'] as String?,
      secondLastName: json['secondLastName'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      token: json['token'] as String?,
      expiration: json['expiration'] == null
          ? null
          : DateTime.parse(json['expiration'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'firstLastName': instance.firstLastName,
      'secondLastName': instance.secondLastName,
      'roles': instance.roles,
      'token': instance.token,
      'expiration': instance.expiration?.toIso8601String(),
    };
