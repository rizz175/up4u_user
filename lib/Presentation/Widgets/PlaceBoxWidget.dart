import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../Utils/constants.dart';

class PlaceBox extends StatelessWidget {
  PlaceBox({required this.placeList});

  var placeList;

  @override
  Widget build(BuildContext context) {
    var width = getWidth(context);
    var height = getHeight(context);
    return Container(
      margin: const EdgeInsets.only(right: 18),
      width: width * 0.5,

      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 7), // changes position of shadow
            ),
          ],
       color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

         Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(

               child: ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: FadeInImage.assetNetwork(
                     placeholder: "Assets/placeholder.png",
                     image:  placeList.placeImages[0].thumbnail.toString(),
                     width: 50.w,
                     height:17.h,

                     imageErrorBuilder: (context, error, stackTrace) {
                       return Image.asset("Assets/placeholder.png",
                           width: 50.w,
                           height:17.h, fit: BoxFit.cover);
                     },

                     fit: BoxFit.cover,
                   )

               ),
             ),

             Padding(
               padding: EdgeInsets.only(left: 10,right: 10,top: 1.3.h),
               child: Text(
                 placeList.title,
                 style: TextStyle(
                     color: primaryColor,
                     fontWeight: FontWeight.w600,
                     fontSize: 13.sp),
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
               ),
             ),
           ],
         ),
         Column(
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
               child: Row(
                 children: [
                   Icon(
                     Icons.location_pin,
                     color: Colors.red,
                     size: height * 0.018,
                   ),
                   Text(
                     placeList.city,
                     style: TextStyle(
                         color: Colors.black54, fontSize: height * 0.015),
                   )
                 ],
               ),
             ),
             Padding(
                 padding: const EdgeInsets.all(10),
                 child: Row(
                   children: [
                     RatingBar.builder(
                       initialRating:double.parse(placeList.ratingAvg.toString()) ,
                       unratedColor: Colors.black12,
                       minRating: 1,
                       direction: Axis.horizontal,
                       allowHalfRating: true,
                       itemCount: 5,
                       itemSize: 15,
                       itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                       itemBuilder: (context, _) => const Icon(
                         Icons.star,
                         color: Colors.amber,
                       ),
                       onRatingUpdate: (rating) {
                         print(rating);
                       },
                     ),
                     Text(
                       "(${placeList.placeReview.length.toString()})",
                       style: TextStyle(
                           color: Colors.black54, fontSize: height * 0.015),
                     )
                   ],
                 )),
             SizedBox(height: 1.h,)
           ],
         )
        ],
      ),
    );
  }
}
