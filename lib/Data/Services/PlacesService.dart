import 'package:http/http.dart' as http;
import 'package:up4u/Data/Constants/constants.dart';

import '../Constants/constantsMessgae.dart';
import '../local/user_utils.dart';

class PlacesServices {


  getAllPlaces() async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};

    final response = await http.get(
        Uri.parse(Constants.baseURL +"get_all_places"), headers: headers);

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
  getFilterPlaces(var data) async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};

    final response = await http.post(
        Uri.parse(Constants.baseURL +Constants.filterPlaceURL), headers: headers,body:data);

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
  nearbyPlaces(String city) async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};

    var dataBody = {"city": city};
    final response = await http.post(
        Uri.parse(Constants.baseURL + Constants.nearbyPlacesURL),
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
