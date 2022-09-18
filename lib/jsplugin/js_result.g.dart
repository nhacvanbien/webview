// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'js_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Success _$$SuccessFromJson(Map<String, dynamic> json) => _$Success(
      json['code'] as int,
      json['data'],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SuccessToJson(_$Success instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'runtimeType': instance.$type,
    };

_$Error _$$ErrorFromJson(Map<String, dynamic> json) => _$Error(
      json['code'] as int,
      json['message'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ErrorToJson(_$Error instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'runtimeType': instance.$type,
    };
