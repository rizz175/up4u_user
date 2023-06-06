import 'dart:async';
import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:up4u/Data/Model/userResponseModel.dart';

import '../../Data/Constants/constantsMessgae.dart';
import '../../Data/Services/authentication_service.dart';
import '../../Data/local/user_utils.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<registerUserEventPressed>((event, emit) async {
      emit(AuthenticationLoading());

      String result = await AuthenticationService().registerUserWithEmail(
          event.email,
          event.password,
          event.username);

      if (result == ConstantsMessage.successfullRegistration) {
        emit(AuthenticationSuccess());
      } else if (result == ConstantsMessage.emailError) {
        emit(AuthenticationFailed(ConstantsMessage.emailError));
      } else {
        emit(AuthenticationFailed(ConstantsMessage.serveError));
      }
    });
    on<loginUserEventPressed>((event, emit) async {
      emit(AuthenticationLoading());

      String result =
          await AuthenticationService().signUser(event.email, event.password);

      if (result == ConstantsMessage.serveError) {
        emit(AuthenticationFailed(ConstantsMessage.serveError));
      } else if (result == ConstantsMessage.incorrectPassword) {
        emit(AuthenticationFailed(ConstantsMessage.incorrectPassword));
      } else if (result == ConstantsMessage.userNotFound) {
        emit(AuthenticationFailed(ConstantsMessage.userNotFound));
      } else {
        var decodedResponse = jsonDecode(result);
        userResponseModel responseModel = userResponseModel.fromJson(decodedResponse);
        UserInfo? userInfo = responseModel.body?.userInfo;
        String? tokken = responseModel.body?.accessToken.toString();
        var success = await UserUtils()
            .saveUserInfo(responseModel.body?.userInfo, tokken!);

        if (success) {
          emit(AuthenticationSuccess());
        }
      }
    });

    on<logoutUserEventPressed>((event, emit) async {
      emit(AuthenticationLoading());
      String result = await AuthenticationService().userLogout();

      if (result == ConstantsMessage.successLogout) {
        emit(AuthenticationSuccess());
      } else if (result == ConstantsMessage.serveError) {
        emit(AuthenticationFailed(ConstantsMessage.serveError));
      } else {
        emit(AuthenticationFailed(ConstantsMessage.serveError));
      }
    });

  }
}
