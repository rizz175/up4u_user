part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class RefreshReviewsEvent extends ReviewEvent
{

  String placeID;

  RefreshReviewsEvent({required this.placeID});
}

