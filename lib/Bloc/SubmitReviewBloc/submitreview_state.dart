part of 'submitreview_bloc.dart';

abstract class submitReviewState extends Equatable {
  const submitReviewState();
  @override
  List<Object> get props => [];
}

class submitReviewInitial extends submitReviewState {

}


/// for submit Reviews
class ReviewSubmitLoadingState extends submitReviewState {
}
class ReviewSubmitFailedState extends submitReviewState {

}
class ReviewSubmitSuccessState extends submitReviewState {
}