import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:up4u/Bloc/FavBloc/fav_bloc.dart';
import 'package:up4u/Bloc/NearbyBloc/nearby_bloc.dart';

import 'Bloc/PlacesBlox/place_bloc.dart';

import 'Bloc/ReviewsBloc/review_bloc.dart';
import 'Bloc/SubmitReviewBloc/submitreview_bloc.dart';
import 'Bloc/UserBloc/user_bloc.dart';

import 'Presentation/Screens/Starting/splash.dart';
import 'Presentation/Utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(create: (context) => AuthenticationBloc(),lazy:false,),
          BlocProvider<UserBloc>(create: (context) => UserBloc(),lazy:false,),
          BlocProvider<nearbyBloc>(create: (context) => nearbyBloc(),lazy:false,),
          BlocProvider<FavBloc>(create: (context) => FavBloc(),lazy:false,),

          BlocProvider<PlaceBloc>(create: (context) => PlaceBloc(),lazy:false,),
          BlocProvider<ReviewBloc>(create: (context) => ReviewBloc(),lazy:false,),
          BlocProvider<SubmitReviewBloc>(create: (context) => SubmitReviewBloc(),lazy:false,)


        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily:"Product Sans" ,
              primaryColor: primaryColor,
              scaffoldBackgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: secondryColor, //change text color of button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ),
            debugShowCheckedModeBanner: false,
            home: const Splashscreen(),
          );
        }));
  }
}
