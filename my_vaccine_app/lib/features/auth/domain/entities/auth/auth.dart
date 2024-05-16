import 'package:hive/hive.dart';
import 'package:my_vaccine_app/features/auth/domain/entities/user/user.dart';
part 'auth.g.dart';

@HiveType(typeId: 0)
class Auth{
  @HiveField(0)
  final User isLoggedIn;

  Auth({required this.isLoggedIn});
}