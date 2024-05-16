import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String id,
    required String email,
    String? firstName,
    String? secondName,
    String? firstLastName,
    String? secondLastName,
    List<String>? roles,
    String? token,
    DateTime? expiration,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
