part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class registerUserEventPressed extends AuthenticationEvent {
  String email;
  String password;
  String username;


  registerUserEventPressed(
      this.email, this.password, this.username);
}

class loginUserEventPressed extends AuthenticationEvent {
  String email;
  String password;


  loginUserEventPressed(this.email, this.password);
}

class logoutUserEventPressed extends AuthenticationEvent
{

  logoutUserEventPressed();
}

//
// class verifyEmailEventPressed extends AuthenticationEvent
// {
// String email;
//
//   verifyEmailEventPressed(this.email);
// }
// class changePasswordEventPressed extends AuthenticationEvent
// {
//   String password;
//   String code;
//   String email;
//
//   changePasswordEventPressed(this.code,this.password,this.email);
// }
