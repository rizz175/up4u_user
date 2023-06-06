part of 'fav_bloc.dart';

abstract class FavState extends Equatable {
  const FavState();
  @override
  List<Object> get props => [];
}

class FavInitial extends FavState {

}


/// for submit Reviews
class FavLoadingState extends FavState {
}
class FavFailedState extends FavState {
}
class FavSuccessState extends FavState {
  String msg;

  FavSuccessState(this.msg);
}class FavSuccessListState extends FavState {
  List<Places>favList=[];

  FavSuccessListState(this.favList);
}
class FavSuccessStatus extends FavState {
  bool status;

  FavSuccessStatus(this.status);
}