import 'package:my_vaccine_app/features/auth/domain/entities/user/user.dart';

abstract class AuthLocalDataSource {
  Future<bool> initDb();
  Future<bool> signIn(bool status);
  Future<User> isLoggedIn();
}