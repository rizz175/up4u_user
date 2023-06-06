import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:up4u/Data/Model/userModel.dart';
import 'package:up4u/Presentation/Screens/Authenication/loginScreen.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  bool positionStreamStarted = false;
  final Geolocator geolocator = Geolocator();

  userModel user = userModel();
  var userPosition = Map();
  UserBloc() : super(UserInitialState()) {
    {
      ///--------------------------------------------------------------
      /// Refresh all the data of user

      on<UserRefreshEvent>((event, emit) async {
        try {
          SharedPreferences shared_User = await SharedPreferences.getInstance();
          user = userModel.fromJson(jsonDecode(shared_User.getString('user')!));

        } catch (e) {
          emit(UserFailedState());
        }
      });

      ///--------------------------------------------------------------
      /// Get User Location

      on<UserLocationEvent>((event, emit) async {
        try {
          emit(UserLoadingState());
          Position position = await getCurrentPosition();
          userPosition['long'] = position.longitude;
          userPosition['lat'] = position.latitude;
          emit(UserSuccessState());
        } catch (e) {
          emit(UserFailedState());
        }
      });

      ///--------------------------------------------------------------
      ///logout Event

      on<UserLogoutEvent>((event, emit) async {
        emit(UserLoadingState());

        try {
          SharedPreferences shared_User = await SharedPreferences.getInstance();

          await shared_User.remove('user');

          Navigator.of(event.context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) => false);
        } catch (e) {
          emit(UserFailedState());
        }
      });

      ///--------------------------------------------------------------
      ///Insert Data into local DB
      on<UserInsertEvent>((event, emit) async {
        try {
          SharedPreferences shared_User = await SharedPreferences.getInstance();
          String userString = jsonEncode(event.user);
          shared_User.setString('user', userString);
        } catch (e) {
          emit(UserFailedState());
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
