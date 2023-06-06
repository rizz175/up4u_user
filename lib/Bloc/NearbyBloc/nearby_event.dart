part of 'nearby_bloc.dart';

abstract class NearbyEvent extends Equatable {
  const NearbyEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NearbyTriggerEvent extends NearbyEvent {
  const NearbyTriggerEvent();
}
class PlacesNearbyEvent extends NearbyEvent {

BuildContext context;
PlacesNearbyEvent(this.context);
}