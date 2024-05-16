import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_vaccine_app/core/use_case/base_use_case.dart';
import 'package:my_vaccine_app/features/auth/domain/entities/user/user.dart';
import 'package:my_vaccine_app/features/auth/domain/entities/user_info/user_info.dart';
import 'package:my_vaccine_app/features/auth/domain/use_cases/is_logged_in_use_case.dart';
import 'package:my_vaccine_app/features/auth/domain/use_cases/login_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsLoggedInUseCase isLoggedInUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase, required this.isLoggedInUseCase}) : super(const AuthState.initial()) {
    
    on<AuthLogin>((event, emit) async {
      final response = await loginUseCase.login( event.email,  event.password);
      response.fold(
        (failure) => emit(const AuthState.failed()),
        (user) => emit(AuthState.success(user)),
      );
    });

    // on<GetUserInfo>((event, emit) async {
    //   final response = await getUserInfoUseCase(NoParams());
    //   response.fold(
    //     (failure) => emit(const AuthState.failed()),
    //     (userInfo) => emit(AuthState.success(true)),
    //   );
    // });

    on<IsLoggedInEvent>((event, emit) async {
      final response = await isLoggedInUseCase(const DefaultParams());
      response.fold(
        (failure) => emit(const AuthState.failed()),
        (isLoggedIn) {
          if (isLoggedIn!=null) {
            // emit(AuthState.success(User));
          } else {
            emit(const AuthState.failed());
          }
        },
      );
    });
  }
}