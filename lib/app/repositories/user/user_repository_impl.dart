import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../exception/auth_exception.dart';
import './user_repository.dart';

 class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'email-already-in-use') {
        final loginTypes =
        await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado, por favor escolha outro e-mail');
        } else {
          throw AuthException(
              message:
              'Você se cadastrou no TodoList pelo Google, por favor utilize ele para entrar!!!');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async{
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      
      return userCredential.user;
    } on PlatformException catch (e,s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar o login');
    } on FirebaseAuthException catch(e,s){
      print(e);
      print(s);
      if(e.code == 'wrong-password' || e.code == 'user-not-found'){
        throw AuthException(message: 'Loin ou senha inválidos');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar o login');
    }
  }

  @override
  Future<void> forgotPassword(String email)async {
    try {
      final loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if(loginMethods.contains('password')){
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      }else{
        throw AuthException(message: 'Cadastro realizado com o google, não pode ser resetado a senha');
      }
    } on PlatformException catch (e,s) {
      print(e);
      print(s);
      throw AuthException(message: 'Erro ao resetar a senha');
    }
  }


}