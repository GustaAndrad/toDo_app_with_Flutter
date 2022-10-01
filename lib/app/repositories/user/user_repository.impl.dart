// ignore_for_file: body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

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
          throw AuthException(message: 'Email ja utilizado');
        } else {
          throw AuthException(message: 'Você já se cadastrou com o google');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuario');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'user-not-found') {
        throw AuthException(message: 'E-mail invalido');
      } else if (e.code == 'wrong-password') {
        throw AuthException(message: 'Senha inválida');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                'Cadastros realizados com o google nao podem ter senhas resetadas');
      } else {
        throw AuthException(message: 'Email não cadastrado');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: 'Erro ao resetar a senha ');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains('password')) {
          throw AuthException(message: 'Você já se cadastrou com este email');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredencial = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          var userCredencial =
              await _firebaseAuth.signInWithCredential(firebaseCredencial);
          return userCredencial.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(message: '''
          Login invalido, você se registrou com os seguintes provedores:
          ${loginMethods?.join(',')}
          ''');
      } else {
        throw AuthException(message: 'Erro ao realizar login');
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}
