part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PlacesTriggerEvent extends PlaceEvent {
  BuildContext context;

  PlacesTriggerEvent(this.context);
}

class PlacesTriggerFilterEvent extends PlaceEvent {
  BuildContext context;
  var data;

  PlacesTriggerFilterEvent(this.context, this.data);
}