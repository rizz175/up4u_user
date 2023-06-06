import 'dart:async';
import 'dart:developer';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:up4u/Presentation/Screens/Authenication/loginScreen.dart';

import '../../../Bloc/UserBloc/user_bloc.dart';
import '../../../Data/Model/userModel.dart';
import '../../../Data/local/user_utils.dart';
import '../../Widgets/LoadingWidget.dart';
import '../Bottom_Navigation/Bottommenu.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(UserRefreshEvent());
    BlocProvider.of<UserBloc>(context).add(UserLocationEvent());

    super.initState();
  }

  startSplashScreen() async {
    final loggedIN = await UserUtils().getLoggedIn();
    if (loggedIN =="yes") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserSuccessState) {
                startSplashScreen();
              }
              else if (state is UserFailedState) {
                log("failed");
              }
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "Assets/mainlogo.png",
                    ),
                  ),
                  const DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: LoadingBar(),
                  ),
                ],
              ),
            )));
  }
}
