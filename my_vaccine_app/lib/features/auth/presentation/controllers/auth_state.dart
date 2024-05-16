 part of 'auth_bloc.dart';
enum AuthStatus { checking, authenticated, unauthenticated }

@freezed
class AuthState with _$AuthState {
   const factory AuthState({
    @Default(AuthStatus.checking) AuthStatus authStatus,
    User? user,
    String? errorMessage,
    UserInfo? userInfo,
  }) = _AuthState;
  const factory AuthState.initial() = _Initial;
  const factory AuthState.success(User status) = _Success;
  const factory AuthState.failed() = _Failed;

}