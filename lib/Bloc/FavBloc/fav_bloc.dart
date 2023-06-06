import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up4u/Data/Model/favePlaceMode.dart';

import 'package:up4u/Data/Services/ReviewService.dart';
import 'package:up4u/Data/Services/favoriteServices.dart';

import '../../Data/Constants/constantsMessgae.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavInitial()) {
    {
      on<addFavEvent>((event, emit) async {
        try {
          emit(FavLoadingState());

          var result = await FavService().AddFav(event.Data);
          if (result == ConstantsMessage.successfullfav) {
            emit(FavSuccessState(result));
          } else if (result == ConstantsMessage.serveError) {
            emit(FavFailedState());
          } else {
            emit(FavFailedState());
          }
        } catch (e) {
          emit(FavFailedState());
        }
      });
      on<removeFavEvent>((event, emit) async {
        try {
          emit(FavLoadingState());

          var result = await FavService().RemoveFav(event.Data);
          if (result == ConstantsMessage.successfullunFav) {
            emit(FavSuccessState(result));
          } else if (result == ConstantsMessage.serveError) {
            emit(FavFailedState());
          } else {
            emit(FavFailedState());
          }
        } catch (e) {
          emit(FavFailedState());
        }
      });
      on<getstatusEvent>((event, emit) async {
        try {
          emit(FavLoadingState());

          var result = await FavService().getStatus(event.Data);

          if (result == false) {
            emit(FavSuccessStatus(false));
          } else if (result == true) {
            emit(FavSuccessStatus(true));
          } else {
            emit(FavFailedState());
          }
        } catch (e) {
          emit(FavFailedState());
        }
      });
      on<favListEvent>((event, emit) async {
        emit(FavLoadingState());
        try {
          final data = await FavService().fetchFavList();
          if (data == ConstantsMessage.serveError) {
            emit(FavFailedState());
          } else if (data == ConstantsMessage.noDataFound) {
            emit(FavFailedState());
          } else {
            var decodedResponse = jsonDecode(data);
            favPlaceModel responseModel =
                favPlaceModel.fromJson(decodedResponse);
            List<Places> placeList = responseModel.body?.places ?? [];

            if (placeList.isEmpty) {
              emit(FavFailedState());
            } else {
              emit(FavSuccessListState(placeList));
            }
          }
        } catch (e) {
          emit(FavFailedState());
        }
      });
    }
  }
}
