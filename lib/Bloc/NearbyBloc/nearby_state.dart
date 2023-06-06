part of 'nearby_bloc.dart';

abstract class NearbyState extends Equatable {
  const NearbyState();
  @override
  List<Object> get props => [];
}

class NearbyInitial extends NearbyState {}

class NearbyLoading extends NearbyState {}

class NearbySuccessfull extends NearbyState {
  List<NearbyPlaces> placeList;
  NearbySuccessfull({required this.placeList});
}

class NearbyFailed extends NearbyState {
  String failedMessage;

  NearbyFailed({required this.failedMessage});
}
