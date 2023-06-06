part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserRefreshEvent extends UserEvent {
  UserRefreshEvent();
}

class UserInsertEvent extends UserEvent {
  userModel user;

  UserInsertEvent(this.user);
}
class UserLocationEvent extends UserEvent {

}

class UserLogoutEvent extends UserEvent {
  BuildContext context;

  UserLogoutEvent(this.context);
}
