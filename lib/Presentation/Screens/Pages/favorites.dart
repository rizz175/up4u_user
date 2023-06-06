import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Bloc/FavBloc/fav_bloc.dart';
import 'package:up4u/Presentation/Utils/constants.dart';

import '../../../Bloc/NearbyBloc/nearby_bloc.dart';
import '../../Widgets/LoadingWidget.dart';
import '../../Widgets/PlaceBoxVertical.dart';
import 'detailed_place.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<FavBloc>(context).add(favListEvent());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = getHeight(context);
    var width = getWidth(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 9.h,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.arrow_left_circle_fill,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        centerTitle: true,
        title: Text("Favorieten",
            style: TextStyle(
                fontSize: 16.sp,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            left: 20, top:20, right: 20, bottom: 10),
        child: BlocConsumer<FavBloc, FavState>(
            builder: (context, state) {
              if (state is FavLoadingState) {
                return const Center(child: LoadingBar());
              }
              if (state is FavSuccessListState) {
                return ListView.builder(
                  itemCount: state.favList.length,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailedScreen(
                                          state.favList[index].place)));
                        },
                        child: PlaceBoxVertical(
                            state.favList[index].place));
                  }),
                );
              } else {
                return Container();
              }
            },
            listener: (context, state) {}),
      ),
    );
  }
}
