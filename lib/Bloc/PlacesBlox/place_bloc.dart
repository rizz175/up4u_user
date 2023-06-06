
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up4u/Data/Services/PlacesService.dart';

import '../../Data/Constants/constantsMessgae.dart';

import '../../Data/Model/placeModel.dart';
import '../../data/constants/Constants.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {




  PlaceBloc() : super(PlaceInitial()) {
    {
      on<PlacesTriggerEvent>((event, emit) async {
        emit(PlaceLoading());
        try {

          final data = await PlacesServices().getAllPlaces();
          if (data == ConstantsMessage.serveError) {
            emit(PlaceFailed(failedMessage: data));

          }
          else if (data == ConstantsMessage.noDataFound) {
            emit(PlaceFailed(failedMessage: data));

          }
          else {
            var decodedResponse = jsonDecode(data);
            responsePlacesModel responseModel = responsePlacesModel.fromJson(decodedResponse);
            List<Places> placeList = responseModel.body?.places ?? [];

            if (placeList.isEmpty) {
              emit(PlaceFailed(failedMessage: ConstantsMessage.noDataFound));
            }
            else {
              emit(PlaceSuccessfull(placeList: placeList));
            }

          }
        } catch (e) {
          emit(PlaceFailed(failedMessage: Constants.serveError));
        }
      });
      on<PlacesTriggerFilterEvent>((event, emit) async {
        emit(PlaceLoading());
        try {

          final data = await PlacesServices().getFilterPlaces(event.data);
          if (data == ConstantsMessage.serveError) {
            emit(PlaceFailed(failedMessage: data));

          } else if (data == ConstantsMessage.noDataFound) {
            emit(PlaceFailed(failedMessage: data));

          }
          else {
            var decodedResponse = jsonDecode(data);
            responsePlacesModel responseModel = responsePlacesModel.fromJson(decodedResponse);
            List<Places> placeList = responseModel.body?.places ?? [];

            if (placeList.isEmpty) {
              emit(PlaceFailed(failedMessage: ConstantsMessage.noDataFound));
            }
            else {
              emit(PlaceSuccessfull(placeList: placeList));
            }

          }
        } catch (e) {
          emit(PlaceFailed(failedMessage: Constants.serveError));
        }
      });
    }
  }
}
