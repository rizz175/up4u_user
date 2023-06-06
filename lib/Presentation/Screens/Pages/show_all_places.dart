import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Bloc/NearbyBloc/nearby_bloc.dart';
import 'package:up4u/Presentation/Screens/Pages/filter.dart';

import 'package:up4u/Presentation/Utils/constants.dart';
import 'package:up4u/Presentation/Widgets/PlaceBoxVertical.dart';
import '../../../Bloc/PlacesBlox/place_bloc.dart';
import '../../Widgets/LoadingWidget.dart';
import 'detailed_place.dart';

class showAllPlaces extends StatefulWidget {
  bool nearby;

  showAllPlaces(this.nearby);

  @override
  State<showAllPlaces> createState() => _showAllPlacesState();
}

class _showAllPlacesState extends State<showAllPlaces> {
  bool checknearby = false;
  @override
  void initState() {


    // TODO: implement initState
    if (widget.nearby) {
      checknearby = true;
    } else {
      BlocProvider.of<PlaceBloc>(context).add(PlacesTriggerEvent(context));
    }

    super.initState();
  }

  getFilter() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FilterScreen()));
    log(result.toString());
    if (result.toString() != null)
    {

      BlocProvider.of<PlaceBloc>(context).add(PlacesTriggerFilterEvent(context,result));

    } else {}
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
        title: Text("Zoek Restaurant",
            style: TextStyle(
                fontSize: 16.sp,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            left: 20, top: height * 0.02, right: 20, bottom: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 6.8.h,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.search,
                          color: primaryColor,
                          size: 17.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: width * 0.6,
                          child: TextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Zoeken"),
                            style: TextStyle(
                                color: primaryColor.withOpacity(.8),
                                fontSize: 17,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        getFilter();
                      },
                      child: Image.asset(
                        "Assets/setting.png",
                        color: primaryColor.withOpacity(0.7),
                        width: 27,
                        height: 27,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 4.h,
            ),
            checknearby
                ? Expanded(
                    child: BlocConsumer<nearbyBloc, NearbyState>(
                        builder: (context, state) {
                          if (state is NearbyLoading) {
                            return const Center(child: LoadingBar());
                          }
                          if (state is NearbySuccessfull) {
                            return ListView.builder(
                              itemCount: state.placeList.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailedScreen(
                                                      state.placeList[index])));
                                    },
                                    child: PlaceBoxVertical(
                                        state.placeList[index]));
                              }),
                            );
                          } else {
                            return Container();
                          }
                        },
                        listener: (context, state) {}))
                : Expanded(
                    child: BlocConsumer<PlaceBloc, PlaceState>(
                        builder: (context, state) {
                          if (state is PlaceLoading) {
                            return const Center(child: LoadingBar());
                          }
                          if (state is PlaceSuccessfull) {
                            return ListView.builder(
                              itemCount: state.placeList.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailedScreen(
                                                      state.placeList[index])));
                                    },
                                    child: PlaceBoxVertical(
                                        state.placeList[index]));
                              }),
                            );
                          } else {
                            return Container();
                          }
                        },
                        listener: (context, state) {})),
          ],
        ),
      ),
    );
  }
}
