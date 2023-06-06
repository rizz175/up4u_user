
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:up4u/Data/Services/PlacesService.dart';

import '../../Data/Constants/constantsMessgae.dart';
import '../../Data/Model/nearbyModel.dart';

import '../../Data/Model/userModel.dart';
import '../../data/constants/Constants.dart';

part 'nearby_event.dart';
part 'nearby_state.dart';

class nearbyBloc extends Bloc<NearbyEvent, NearbyState> {

  List<NearbyPlaces>nearbyList=[];
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  bool positionStreamStarted = false;
  final Geolocator geolocator = Geolocator();
  nearbyBloc() : super(NearbyInitial()) {
    {
      on<PlacesNearbyEvent>((event, emit) async {
        emit(NearbyLoading());
        try {
          Position position = await getCurrentPosition();
          List<Placemark> addresses = await
          placemarkFromCoordinates(position.latitude,position.longitude);
          String? city=addresses.first.locality;

          final data = await PlacesServices().nearbyPlaces(city.toString());
          if (data == ConstantsMessage.serveError) {
            emit(NearbyFailed(failedMessage: data));

          } else if (data == ConstantsMessage.noDataFound) {
            emit(NearbyFailed(failedMessage: data));

          }
          else {
            var decodedResponse = jsonDecode(data);
            nearbyModel responseModel = nearbyModel.fromJson(decodedResponse);
            nearbyList = responseModel.body?.nearbyPlaces ?? [];

            if (nearbyList.isEmpty) {
              emit(NearbyFailed(failedMessage: ConstantsMessage.noDataFound));
            }
            else {
              emit(NearbySuccessfull(placeList: nearbyList));
            }

          }
        } catch (e) {
          emit(NearbyFailed(failedMessage: Constants.serveError));
        }
      });
    }
  }
  getCurrentPosition() async {
    final hasPermission = await handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();

    return position;
  }

  handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return false;
    }
    return true;
  }

}
