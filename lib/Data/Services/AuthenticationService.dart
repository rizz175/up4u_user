import 'package:http/http.dart' as http;

import '../../data/constants/Constants.dart';

class AuthententicationService {
  registerUserService(var data) async {
    final response = await http.post(
        Uri.parse(Constants.baseURL + Constants.registrationURL),
        body: data);
     print(response.body);
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(Constants.statusError);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  loginUser(var data) async {
    final response = await http
        .post(Uri.parse(Constants.baseURL + Constants.loginURL), body: data);
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(Constants.statusError);
      }
    } catch (e) {
      return Constants.statusError;
    }
  }
}
