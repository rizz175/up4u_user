import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:up4u/Presentation/Widgets/starsWidget.dart';

import '../Utils/constants.dart';

class PlaceBoxVertical extends StatelessWidget {


  var placeList;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(10)),
        child: ListTile(
          isThreeLine: true,
          leading: SizedBox(
            height:25.h,
            width: 20.w,
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(10),
              child:FadeInImage.assetNetwork(
                placeholder: "Assets/placeholder.png",
                image:  placeList.placeImages[0].thumbnail.toString(),


                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset("Assets/placeholder.png",
                       fit: BoxFit.cover);
                },

                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            placeList.title,
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize:13.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 10.sp,
                  ),
                  Text(
                   placeList.city,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize:8.sp,
                  ))
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  IconTheme(
                    data: IconThemeData(

                      size: 10.sp,
                    ),
                    child: StarDisplay(value: double.parse(placeList.ratingAvg.toString()).toInt()),
                  ),

                  Text(
                    "(${placeList.placeReview.length.toString()})",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize:10.sp),
                  )
                ],
              )
            ],
          ),
        ));
  }

  PlaceBoxVertical(this.placeList);
}