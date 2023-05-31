// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(
      {required String emailAddress,
      required String password,
      required String username}) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      CollectionReference addUser =
          FirebaseFirestore.instance.collection('users');
      addUser.add({
        'email': emailAddress,
        'name': username,
        'password': password,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(massageFail: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            massageFail: 'The account already exists for that email.🤨'));
      }
    }
  }
}
