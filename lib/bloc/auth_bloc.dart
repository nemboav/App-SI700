import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trabalho_01/provider/user_provider.dart';
import '../model/user_profile.dart';
import '../provider/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthenticationService _authenticationService =
      FirebaseAuthenticationService();

  AuthBloc() : super(Unauthenticated()) {
    _authenticationService.user.listen((event) {
      add(AuthServerEvent(event));
    });

    on<AuthServerEvent>((event, emit) {
      if (event.userProfile == null) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated(userProfile: event.userProfile!));
      }
    });

    on<RegisterUser>((event, emit) async {
      try {
        UserProfile user = event.user;
        UserProfile? user1 = await _authenticationService
            .createUserWithEmailAndPassword(user.email!, user.password!);
        user.uid = user1?.uid;
        await UserProvider.helper.insertUser(user);
        emit(Authenticated(userProfile: user));
        //add(LoginUser(username: user.email!, password: user.password!));
      } catch (e) {
        emit(AuthError(message: "Não foi possível registrar: ${e.toString()}"));
      }
    });

    on<LoginUser>((event, emit) async {
      try {
        await _authenticationService.signInWithEmailAndPassword(
            event.username, event.password);
      } catch (e) {
        emit(AuthError(
            message:
                "Não foi possível logar com ${event.username}: ${e.toString()}"));
      }
    });

    on<LoginAnonymousUser>((event, emit) async {
      try {
        await _authenticationService.signinAnon();
      } catch (e) {
        emit(AuthError(
            message: "Não foi possível acessar anonimamente: ${e.toString()}"));
      }
    });

    on<Logout>((event, emit) async {
      try {
        await _authenticationService.signOut();
      } catch (e) {
        emit(AuthError(
            message: "Não foi possível efetuar logout: ${e.toString()}"));
      }
    });
  }
}

/*
  Eventos
*/

abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  UserProfile user;

  RegisterUser({required this.user});
}

class LoginUser extends AuthEvent {
  String username;
  String password;

  LoginUser({required this.username, required this.password});
}

class LoginAnonymousUser extends AuthEvent {}

class Logout extends AuthEvent {}

class AuthServerEvent extends AuthEvent {
  final UserProfile? userProfile;
  AuthServerEvent(this.userProfile);
}

/*
Estados
*/

abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  UserProfile userProfile;
  Authenticated({required this.userProfile});
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
