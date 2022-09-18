import 'package:freezed_annotation/freezed_annotation.dart';

part 'js_result.freezed.dart';
part 'js_result.g.dart';

@freezed
class JsResult with _$JsResult {
   factory JsResult.success(int code, dynamic data) = Success;
   factory JsResult.error(int code, String? message) = Error;

   factory JsResult.fromJson(Map<String, Object?> json)
   => _$JsResultFromJson(json);
}