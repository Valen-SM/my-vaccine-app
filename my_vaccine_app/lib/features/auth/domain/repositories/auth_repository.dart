import 'package:dartz/dartz.dart';
import 'package:my_vaccine_app/core/error/failure.dart';
import 'package:my_vaccine_app/features/auth/domain/entities/user/user.dart';
import 'package:my_vaccine_app/features/auth/domain/entities/user_info/user_info.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> signIn(bool status);
  Future<Either<Failure, User>> isLoggedIn();
  Future<Either<Failure, User>> login(String email, String password);
  Future<User?> register(String email, String password);
  Future<User?> checkStatus(String token);
  Future<UserInfo?> getUserInfoAuth(String token);
}