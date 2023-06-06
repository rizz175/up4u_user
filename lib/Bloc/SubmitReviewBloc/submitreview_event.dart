part of 'submitreview_bloc.dart';

abstract class SubmitReviewEvent extends Equatable {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}


class submitReviewEvent extends SubmitReviewEvent
{

  var Data;

  submitReviewEvent({required this.Data});
}
