
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:up4u/Data/Services/ReviewService.dart';

import '../../Data/Constants/constantsMessgae.dart';

part 'submitreview_event.dart';
part 'submitreview_state.dart';

class SubmitReviewBloc extends Bloc<SubmitReviewEvent, submitReviewState> {


  SubmitReviewBloc() : super(submitReviewInitial()) {
    {
      on<submitReviewEvent>((event, emit) async {
        try {
          emit(ReviewSubmitLoadingState());

          var result = await ReviewService().submitReviewService(event.Data);
          if (result == ConstantsMessage.successfullReview) {
            emit(ReviewSubmitSuccessState());
          } else if (result == ConstantsMessage.serveError) {
            emit(ReviewSubmitFailedState());
          } else {
            emit(ReviewSubmitFailedState());
          }
        } catch (e) {
          emit(ReviewSubmitFailedState());
        }
      }
      );

    }
  }
}
