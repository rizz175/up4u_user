part of 'fav_bloc.dart';

abstract class FavEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class addFavEvent extends FavEvent {
  var Data;

  addFavEvent({required this.Data});
}

class removeFavEvent extends FavEvent {
  var Data;

  removeFavEvent({required this.Data});
}

class favListEvent extends FavEvent {}

class getstatusEvent extends FavEvent {
  var Data;

  getstatusEvent(this.Data);
}
