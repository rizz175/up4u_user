part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceSuccessfull extends PlaceState {
  List<Places> placeList;
  PlaceSuccessfull({required this.placeList});
}

class PlaceFailed extends PlaceState {
  String failedMessage;

  PlaceFailed({required this.failedMessage});
}
