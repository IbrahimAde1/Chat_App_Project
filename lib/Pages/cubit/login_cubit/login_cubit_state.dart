part of 'login_cubit.dart';

@immutable
abstract class LoginCubitState {}

class LoginCubitInitial extends LoginCubitState {}

class LoginCubitLoading extends LoginCubitState {}

class LoginCubitSaccess extends LoginCubitState {}

class LoginCubitFailure extends LoginCubitState {
  final String massage;
  LoginCubitFailure({required this.massage});
}
