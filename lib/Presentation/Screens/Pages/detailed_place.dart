import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:favorite_button/favorite_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Bloc/FavBloc/fav_bloc.dart';
import 'package:up4u/Bloc/ReviewsBloc/review_bloc.dart';
import 'package:up4u/Data/Constants/constantsMessgae.dart';
import 'package:up4u/Presentation/Screens/Pages/reviews_list.dart';
import 'package:up4u/Presentation/Utils/constants.dart';
import 'package:up4u/Presentation/Utils/usefulMethods.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Bloc/UserBloc/user_bloc.dart';
import '../../Widgets/LoadingWidget.dart';
import '../../Widgets/starsWidget.dart';
import 'image_preview.dart';

class DetailedScreen extends StatefulWidget {
  var placeDetail;

  DetailedScreen(this.placeDetail);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  bool details = true;
  bool location = false;
  bool reviews = false;
  bool isFav = false;
  List imagesList = [];
  var currentPostion;

  bool positionStreamStarted = false;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};

  void addMarker() {
    markers.clear();

    setState(() {
      Marker resultMarker = Marker(
          markerId: const MarkerId("1"),
          position: LatLng(double.parse(widget.placeDetail.latitude),
              double.parse(widget.placeDetail.longitude)));
      markers.add(resultMarker);
    });
  }

  @override
  initState() {
    var data = {"place_id": widget.placeDetail.id.toString()};
    BlocProvider.of<FavBloc>(context).add(getstatusEvent(data));

    addMarker();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentPostion = BlocProvider.of<UserBloc>(context).userPosition;

    var width = getWidth(context);
    var height = getHeight(context);
    return Scaffold(
      body: BlocConsumer<FavBloc, FavState>(
        listener: (context, state) {
          if (state is FavSuccessStatus) {
            isFav = state.status;
          } else if (state is FavFailedState) {
            UsefullMethods.showMessage(ConstantsMessage.serveError);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            color: Colors.white,
            opacity: .8,
            progressIndicator: const LoadingBar(),
            inAsyncCall: state is FavLoadingState ? true : false,
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: height * 0.45,
                  child: Stack(clipBehavior: Clip.none, children: [
                    SizedBox(
                      width: width,
                      height: height * 0.45,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.transparent],
                          ).createShader(
                              Rect.fromLTRB(0, 150, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: FadeInImage.assetNetwork(
                          placeholder: "Assets/placeholder.png",
                          image: widget.placeDetail.placeImages[0].placeImageUrl
                              .toString(),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset("Assets/placeholder.png",
                                fit: BoxFit.cover);
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        top: height * 0.05,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 5),
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 17,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                      right: 20,
                      top: height * 0.05,
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                            child: BlocListener<FavBloc, FavState>(
                              listener: (context, state) {
                                if (state is FavSuccessState) {
                                  UsefullMethods.showMessage(state.msg);
                                } else if (state is FavFailedState) {
                                  UsefullMethods.showMessage(
                                      ConstantsMessage.serveError);
                                }
                              },
                              child: FavoriteButton(
                                iconSize: 20,
                                isFavorite: isFav,
                                valueChanged: (fav) {
                                  var data = {
                                    "place_id": widget.placeDetail.id.toString()
                                  };
                                  if (fav) {
                                    BlocProvider.of<FavBloc>(context)
                                        .add(addFavEvent(Data: data));
                                  } else {
                                    BlocProvider.of<FavBloc>(context)
                                        .add(removeFavEvent(Data: data));
                                  }

                                  setState(() {
                                    isFav = fav;
                                  });
                                },
                              ),
                            ),
                          )),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: SizedBox(
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.placeDetail.title}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: height * 0.006,
                              ),
                              Row(
                                children: [
                                  // double.parse(widget.placeDetail.ratingAvg)
                                  IconTheme(
                                    data: IconThemeData(
                                      size: 11.sp,
                                    ),
                                    child: StarDisplay(
                                        value: double.parse(
                                                widget.placeDetail.ratingAvg)
                                            .toInt()),
                                  ),
                                  Text(
                                    "(${widget.placeDetail.placeReview.length})",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: height * 0.015),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  width: 100.w,
                  height: 55.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: 100.w,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 13.sp,
                              ),
                              Flexible(
                                  child: Text(
                                " ${widget.placeDetail.address}",
                                style: TextStyle(fontSize: 9.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    details = true;
                                    reviews = false;
                                    location = false;
                                  });
                                },
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                      color: details
                                          ? primaryColor
                                          : Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.024),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    details = false;
                                    reviews = false;
                                    location = true;
                                  });
                                },
                                child: Text(
                                  "Plaats",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: location
                                          ? primaryColor
                                          : Colors.black45,
                                      fontSize: height * 0.023),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        details = false;
                                        reviews = true;
                                        location = false;
                                      });
                                    },
                                    child: Text(
                                      "Recensies  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: reviews
                                              ? primaryColor
                                              : Colors.black45,
                                          fontSize: height * 0.023),
                                    ),
                                  ),
                                  reviews
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReviewsList(widget
                                                            .placeDetail.id
                                                            .toString())));
                                          },
                                          child: Icon(
                                            Icons.add_circle_rounded,
                                            color: primaryColor,
                                          ))
                                      : Text("")
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.014,
                        ),
                        Visibility(
                          visible: details,
                          child: Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                // ignore: unnecessary_const
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      ReadMoreText(
                                        "${widget.placeDetail.description}",
                                        trimLines: 6,
                                        colorClickableText: Colors.pink,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'Show more',
                                        trimExpandedText: 'Show less',
                                        lessStyle: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.white),
                                        moreStyle: TextStyle(
                                            fontSize: 11.sp,
                                            color: primaryColor),
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black54),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.time_solid,
                                            color: Colors.blue,
                                            size: 13.sp,
                                          ),
                                          Flexible(
                                              child: Text(
                                            " ${widget.placeDetail.timing} 24/7",
                                            style: TextStyle(fontSize: 9.sp),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                        ],
                                      ),
                                      Container(
                                        height: 25.h,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: widget
                                                .placeDetail.placeImages.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ImagePreview(widget
                                                                    .placeDetail
                                                                    .placeImages[
                                                                        index]
                                                                    .placeImageUrl)));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 20,
                                                            right: 10),
                                                    width: 38.w,
                                                    height: 20.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            blurRadius: 4,
                                                            offset: Offset(0,
                                                                7), // changes position of shadow
                                                          ),
                                                        ]),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        placeholder:
                                                            "Assets/placeholder.png",
                                                        image: widget
                                                            .placeDetail
                                                            .placeImages[index]
                                                            .thumbnail
                                                            .toString(),
                                                        imageErrorBuilder:
                                                            (context, error,
                                                                stackTrace) {
                                                          return Image.asset(
                                                              "Assets/placeholder.png",
                                                              fit:
                                                                  BoxFit.cover);
                                                        },
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ));
                                            }),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Visibility(
                          visible: location,
                          child: Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                // ignore: unnecessary_const
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: GoogleMap(
                                            mapType: MapType.normal,
                                            mapToolbarEnabled: false,
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(
                                                  double.parse(widget
                                                      .placeDetail.latitude),
                                                  double.parse(widget
                                                      .placeDetail.longitude)),
                                              zoom: 14.4746,
                                            ),
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              try {
                                                _controller
                                                    .complete(controller);
                                              } catch (e) {}
                                            },
                                            markers: markers,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          child: ElevatedButton(
                                            child:
                                                const Text('Toon routebeschrijving'),
                                            onPressed: () async {
                                              // showDirections();
                                              UsefullMethods
                                                  .launchMapsDirection(
                                                      double.parse(widget
                                                          .placeDetail
                                                          .latitude),
                                                      double.parse(widget
                                                          .placeDetail
                                                          .longitude));
                                            },
                                          ))
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Visibility(
                            visible: reviews,
                            child: Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    // ignore: unnecessary_const
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemCount: widget.placeDetail.placeReview
                                                  .length >
                                              5
                                          ? 5
                                          : widget
                                              .placeDetail.placeReview.length,
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                      itemBuilder: ((context, index) {
                                        var review = widget
                                            .placeDetail.placeReview[index];
                                        String timeCreated = timeago.format(
                                            DateTime.parse(
                                                review.createdAt.toString()));

                                        return GestureDetector(
                                            onTap: () {},
                                            child: Card(
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3.w,
                                                      vertical: 1.h),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black12
                                                          .withOpacity(.001),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        minLeadingWidth: 5,
                                                        minVerticalPadding: 2,
                                                        leading: Container(
                                                            width: width * 0.08,
                                                            height: height *
                                                                0.08,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .amber),
                                                            child: Center(
                                                                child: Text(review
                                                                    .user!
                                                                    .username!
                                                                    .substring(
                                                                        0, 1)
                                                                    .toUpperCase()))),
                                                        title: Text(
                                                          review.user!.username
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        subtitle: Row(
                                                          children: [
                                                            IconTheme(
                                                              data:
                                                                  IconThemeData(
                                                                size: 10.sp,
                                                              ),
                                                              child: StarDisplay(
                                                                  value: double.parse(review
                                                                          .rating
                                                                          .toString())
                                                                      .toInt()),
                                                            ),
                                                            Text(
                                                                double.parse(review
                                                                        .rating
                                                                        .toString())
                                                                    .toStringAsFixed(
                                                                        1),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        9.sp,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                        ),
                                                        trailing: Text(
                                                          "$timeCreated",
                                                          style: TextStyle(
                                                              fontSize: 8.sp,
                                                              color: Colors
                                                                  .black87),
                                                        ),
                                                      ),
                                                      Text(review
                                                          .review,
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              color: Colors
                                                                  .black54))
                                                    ],
                                                  )),
                                            ));
                                      }),
                                    )))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
