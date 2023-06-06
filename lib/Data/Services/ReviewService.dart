import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../data/constants/Constants.dart';
import '../Constants/constantsMessgae.dart';
import '../local/user_utils.dart';

class ReviewService {

  submitReviewService(var data) async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};
    final response = await http.post(
        Uri.parse(Constants.baseURL + Constants.pushReviewURL),
        body: data,headers: headers);


    try{
      if (response.statusCode == 200)
      {
        return  ConstantsMessage.successfullReview;
      }
      else if (response.statusCode == 401) {
        return ConstantsMessage.serveError;
      } else {
        return ConstantsMessage.serveError;
      }
    }catch (e) {
      return ConstantsMessage.serveError;
    }
  }
  fetchReviewService(String placeID) async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};

    var dataBody = {"place_id": placeID};
    final response = await http.post(
        Uri.parse(Constants.baseURL + Constants.allReviewsURL),
        body: dataBody,headers: headers);

    try{
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        return ConstantsMessage.noDataFound;
      } else {
        return ConstantsMessage.serveError;
      }
    }catch (e) {
      return ConstantsMessage.serveError;
    }
  }
}
