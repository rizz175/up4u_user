part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {

}
class AuthenticationLoading extends AuthenticationState {

}
class AuthenticationSuccess extends AuthenticationState {

}
class AuthenticationFailed extends AuthenticationState {
  String message;

  AuthenticationFailed(this.message);
}