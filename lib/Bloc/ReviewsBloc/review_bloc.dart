
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up4u/Data/Constants/constants.dart';
import 'package:up4u/Data/Model/reviewModel.dart';
import 'package:up4u/Presentation/Utils/usefulMethods.dart';

import '../../Data/Constants/constantsMessgae.dart';
import '../../Data/Model/nearbyModel.dart';
import '../../Data/Model/reviewModel.dart';
import '../../Data/Services/ReviewService.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {


  ReviewBloc() : super(ReviewInitial()) {
    {

      /// fetch reviews all

      on<RefreshReviewsEvent>((event, emit) async {
        try {

          emit(ReviewRefreshLoadingState());


           var data = await ReviewService().fetchReviewService(event.placeID);
          if (data == ConstantsMessage.serveError) {
            emit(ReviewRefreshFailedState(data));

          } else if (data == ConstantsMessage.noDataFound) {
            emit(ReviewRefreshFailedState(data));

          }
          else {
            var decodedResponse = jsonDecode(data);
            placeReviews responseModel = placeReviews.fromJson(decodedResponse);
            List<PlaceReviews> reviewData= responseModel.body?.placeReviews?? [];

            if (reviewData.isEmpty) {
              emit(ReviewRefreshFailedState(ConstantsMessage.noDataFound));
            }
            else {
               emit(ReviewRefreshSuccessState(reviewData));
            }

          }
        } catch (e) {
          emit(ReviewRefreshFailedState( Constants.serveError));
        }
      });
    }
  }
}
