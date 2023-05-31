import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit({emailAddress}) : super(LoginCubitInitial());
  String? emailAddress;
  Future<void> login(
      {required String emailAddress, required String password}) async {
    emit(LoginCubitLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      emit(LoginCubitSaccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginCubitFailure(massage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginCubitFailure(massage: 'wrong password'));
      }
    } catch (e) {
      emit(LoginCubitFailure(massage: 'wrog erorr'));
    }
  }
}
