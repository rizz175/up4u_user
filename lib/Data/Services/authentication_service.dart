import 'package:http/http.dart' as http;

import '../../data/constants/Constants.dart';
import '../Constants/constantsMessgae.dart';
import '../local/user_utils.dart';

class AuthenticationService {
  bool emailErrror = false;
  String response = "";

  registerUserWithEmail(String email, String password, String username) async {
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    var dataBody = {
      "username": username,
      "password": password,
      "password_confirmation": password,
      "email": email
    };
    try {
      final response = await http.post(
          Uri.parse(Constants.baseURL + Constants.registrationURL),
          body: dataBody,
          headers: headers);

      if (response.statusCode == 200) {
        return ConstantsMessage.successfullRegistration;
      } else if (response.statusCode == 401) {
        return ConstantsMessage.emailError;
      } else {
        return ConstantsMessage.serveError;
      }
    } catch (e) {
      return ConstantsMessage.serveError;
    }
  }

  signUser(String email, String password) async {
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    var dataBody = {"email": email, "password": password};
    try {
      final response = await http.post(
          Uri.parse(Constants.baseURL + Constants.loginURL),
          body: dataBody);

      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        return ConstantsMessage.incorrectPassword;
      } else {
        return ConstantsMessage.serveError;
      }
    } catch (e) {
      return ConstantsMessage.serveError;
    }
  }

  /// logout service Hits
  userLogout() async {
    String tokken = await UserUtils().getTokken();
    var headers = {"Authorization": tokken};

    try {
      final response = await http
          .post(Uri.parse(Constants.baseURL + "logout_api"), headers: headers);

      if (response.statusCode == 200) {
        return ConstantsMessage.successLogout;
      } else if (response.statusCode == 401) {
        return ConstantsMessage.serveError;
      } else {
        return ConstantsMessage.serveError;
      }
    } catch (e) {
      return ConstantsMessage.serveError;
    }
  }
}
