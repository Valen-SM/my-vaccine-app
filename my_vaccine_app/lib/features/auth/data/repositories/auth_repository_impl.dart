import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_vaccine_app/configurations/constants/environment.dart';
import 'package:my_vaccine_app/core/error/exceptions.dart';
import 'package:my_vaccine_app/core/error/failure.dart';
import 'package:my_vaccine_app/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:my_vaccine_app/features/auth/domain/entities/user/user.dart';
import 'package:my_vaccine_app/features/auth/domain/entities/user_info/user_info.dart';
import 'package:my_vaccine_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthLocalDataSource authLocalDataSource;
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  AuthRepositoryImpl({required this.authLocalDataSource});

  @override
  Future<Either<Failure, User>> isLoggedIn() async{
    try{
      final response = await authLocalDataSource.isLoggedIn();
      return Right(response);
    } on ConnectionException {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signIn(bool status) async {
    try{
      final response = await authLocalDataSource.signIn(status);
      return Right(response);
    } on ConnectionException {
      return Left(ConnectionFailure());
    }
  }
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final response = dio.post('/api/auth/login',
          data: {'username': email, 'password': password});
      final responseFull = (await response).data;
      final user = User.fromJson(responseFull);
      return   Right(user);;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User?> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<User?> checkStatus(String token) async {
    try {
      final response = dio.post('/api/auth/refresh-token', options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ));
      final responseFull = (await response).data;
      final user = User.fromJson(responseFull);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UserInfo?> getUserInfoAuth(String token) async{
    try {
      final response = dio.get('/api/auth/user-info', options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ));
      final responseFull = (await response).data;
      final user = UserInfo.fromJson(responseFull);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

}