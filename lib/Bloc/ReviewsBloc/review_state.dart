part of 'review_bloc.dart';

abstract class ReviewState extends Equatable
{
  const ReviewState();
  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {

}
/// for refreshing reviews
class ReviewRefreshLoadingState extends ReviewState {
}
class ReviewRefreshFailedState extends ReviewState {
  String msg;

  ReviewRefreshFailedState(this.msg);
}
class ReviewRefreshSuccessState extends ReviewState {
  List<PlaceReviews>reviewList=[];

  ReviewRefreshSuccessState(this.reviewList);
}
