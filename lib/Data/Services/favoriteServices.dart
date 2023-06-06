import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../data/constants/Constants.dart';
import '../Constants/constantsMessgae.dart';
import '../local/user_utils.dart';

class FavService {

  AddFav(var data) async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};
    final response = await http.post(
        Uri.parse(Constants.baseURL +"add_favorite"),
        body: data,headers: headers);


    try{
      if (response.statusCode == 200)
      {
        return  ConstantsMessage.successfullfav;
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
  RemoveFav(var data) async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};
    final response = await http.post(
        Uri.parse(Constants.baseURL +"remove_favorite"),
        body: data,headers: headers);


    try{
      if (response.statusCode == 200)
      {
        return  ConstantsMessage.successfullunFav;
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
  getStatus(var data) async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};
    final response = await http.post(
        Uri.parse(Constants.baseURL +"check_favorite_status"),
        body: data,headers: headers);


    try{
      if (response.statusCode == 200)
      {
        return  true;
      }
      else if (response.statusCode == 401) {
        return false;
      } else {
        return ConstantsMessage.serveError;
      }
    }catch (e) {
      return ConstantsMessage.serveError;
    }
  }

  fetchFavList() async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};

    final response = await http.get(
        Uri.parse(Constants.baseURL + 'get_favorite'),headers: headers);

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
  FavStatus(String placeID) async {
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
