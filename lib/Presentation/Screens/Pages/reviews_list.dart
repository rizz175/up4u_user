import 'dart:developer';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Data/Constants/constants.dart';
import 'package:up4u/Presentation/Screens/Pages/Review/reviewScreen.dart';
import 'package:up4u/Presentation/Utils/constants.dart';
import 'package:up4u/Presentation/Utils/usefulMethods.dart';
import '../../../Bloc/ReviewsBloc/review_bloc.dart';
import '../../../Bloc/SubmitReviewBloc/submitreview_bloc.dart';
import '../../../Data/Model/reviewModel.dart';
import '../../../Data/Model/userResponseModel.dart';
import '../../../Data/local/user_utils.dart';
import '../../Widgets/LoadingWidget.dart';
import '../../Widgets/starsWidget.dart';

class ReviewsList extends StatefulWidget {
  String placeID;

  ReviewsList(this.placeID);

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  bool reviewDone = false;
  int totalReview = 0;
  double avgRating = 0;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ReviewBloc>(context)
        .add(RefreshReviewsEvent(placeID: widget.placeID));

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
          title: Text("Recensies ",
              style: TextStyle(
                  fontSize: 16.sp,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(left: 20, top: 3.h, right: 20, bottom: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),

                        blurRadius: 1,
                        // changes position of shadow
                      ),
                    ],
                    color: secondryColor.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text("${avgRating.toStringAsFixed(1)}",
                        style: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),


                    IconTheme(
                      data: IconThemeData(

                        size: 18.sp,
                      ),
                      child: StarDisplay(value:  avgRating.toInt()),
                    ),
                    const SizedBox(height: 5),
                    Text("Gebaseerd op $totalReview recensies",style:Theme.of(context).textTheme.caption,),
                    const SizedBox(height: 10),
                    reviewDone == false
                        ? SizedBox(
                            width: getWidth(context),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                ),
                                onPressed: () async {
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewScreen(widget.placeID)));

                                  if (result != null) {
                                    BlocProvider.of<ReviewBloc>(context).add(
                                        RefreshReviewsEvent(
                                            placeID: widget.placeID));
                                  }
                                },
                                child: const Text(
                                  "Geef een recensie",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                )))
                        : Container()
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                  child: BlocConsumer<ReviewBloc, ReviewState>(
                      builder: (context, state) {
                if (state is ReviewRefreshLoadingState) {
                  return const Center(child: LoadingBar());
                }
                if (state is ReviewRefreshSuccessState) {

                  return ListView.builder(
                    itemCount: state.reviewList.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      var review = state.reviewList[index];
                      String timeCreated = timeago.format(DateTime.parse(review.createdAt.toString()));

                      return GestureDetector(
                          onTap: () {},
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
                              decoration: BoxDecoration(

                                  color: Colors.black12.withOpacity(.001),
                                  borderRadius: BorderRadius.circular(10)),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    minLeadingWidth: 5,
                                    minVerticalPadding: 2,

                                    leading: Container(
                                        width: width * 0.08,
                                        height: height * 0.08,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.amber),
                                        child: Center(
                                            child: Text(review.user!.username!
                                                .substring(0, 1).toUpperCase()))),
                                    title: Text(
                                      review.user!.username.toString(),
                                      style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        IconTheme(
                                          data: IconThemeData(

                                            size: 10.sp,
                                          ),
                                          child: StarDisplay(value: double.parse(review.rating.toString()).toInt()),
                                        ),
                                        Text(double.parse(review.rating.toString()).toStringAsFixed(1),
                                            style: TextStyle(fontSize: 9.sp,color:Colors.black,fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    trailing:Text("$timeCreated",style:TextStyle(fontSize: 8.sp,color:Colors.black87),),
                                  ),
                                  Text(review.review.toString(),style:TextStyle(fontSize: 11.sp,color:Colors.black54))
                                ],
                              )


                            ),
                          ));
                    }),
                  );
                } else {
                  return Container();
                }
              }, listener: (context, state) {
                if (state is ReviewRefreshSuccessState) {
                  setState(() {
                    totalReview = state.reviewList.length;
                    calculatAvg(state.reviewList);
                  });
                }
              }))
            ],
          ),
        ));
  }

  calculatAvg(List<PlaceReviews> reviewList) async {
    double sum = 0;
    UserInfo userInfo = await UserUtils()
        .getUser();
    for (int i = 0; i < reviewList.length; i++) {
      sum += double.parse(reviewList[i].rating.toString());

      if(reviewList[i].user?.id==userInfo.id)
        {
          reviewDone=true;
        }

    }

    avgRating = sum / reviewList.length;
  }
}
