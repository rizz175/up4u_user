import 'dart:math';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Data/Constants/constants.dart';
import 'package:up4u/Presentation/Utils/constants.dart';
import 'package:up4u/Presentation/Utils/usefulMethods.dart';

import '../../../../Bloc/ReviewsBloc/review_bloc.dart';
import '../../../../Bloc/SubmitReviewBloc/submitreview_bloc.dart';
import '../../../../Data/Model/userResponseModel.dart';
import '../../../../Data/local/user_utils.dart';
import '../../../Widgets/LoadingWidget.dart';

class ReviewScreen extends StatefulWidget {
  String placeID;

  ReviewScreen(this.placeID);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool reviewDone = false;
  double rating = 0;
  String review = "";
  List<String> selectReview = [];
  List<String> options = [
    'Excellent',
    'WonderFull',
    'Amazing',
    'Classy',
    'Good',
    'Very Good'
  ];
  List<int> tag = [];
  @override
  void initState() {
    // TODO: implement initState

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
        body: BlocConsumer<SubmitReviewBloc, submitReviewState>(
          listener: (context, state) {
            if (state is ReviewSubmitSuccessState) {
              UsefullMethods.showMessage(Constants.reviewsuccessfullMessage);
              Navigator.pop(context, "done");
            } else if (state is ReviewSubmitFailedState) {
              UsefullMethods.showMessage(Constants.serveError);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is ReviewSubmitLoadingState ? true : false,
              color: Colors.white,
              opacity: .8,
              progressIndicator: const LoadingBar(),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 3.h, right: 20, bottom: 10),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: getHeight(context) * 0.03),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Geef feedback",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
                        initialRating: rating,
                        unratedColor: Colors.black12,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 35,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rat) {
                          setState(() {
                            rating = rat;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ChipsChoice<int>.multiple(
                        value: tag,
                        onChanged: (val) => setState(() => tag = val),
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: options,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                        choiceStyle: const C2ChoiceStyle(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black,
                        ),
                        wrapped: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: getWidth(context) * 0.4,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Niet nu",
                                  ))),
                          SizedBox(
                            width: getWidth(context) * 0.4,
                            child: ElevatedButton(
                                onPressed: () async {
                                  review = await getChips();

                                  UserInfo userInfo =
                                      await UserUtils().getUser();
                                  var data = {
                                    "placeID": widget.placeID.toString(),
                                    "userID": userInfo.id.toString(),
                                    "username": userInfo.username,
                                    "review": review.toString(),
                                    "rating": rating.toString()
                                  };

                                  BlocProvider.of<SubmitReviewBloc>(context)
                                      .add(submitReviewEvent(Data: data));
                                },
                                child: const Text("Indienen")),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  getChips() {
    selectReview.clear();

    for (int i = 0; i < tag.length; i++) {
      selectReview.add(options[tag[i]]);
    }

    return selectReview.join(",");
  }
}
