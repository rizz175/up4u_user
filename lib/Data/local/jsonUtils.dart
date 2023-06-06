import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:up4u/Data/Model/citiesModel.dart';

class JsonUtils
{


  Future<List> readCitiesFromJson() async {
    List<citiesModel>citylist=[];
    final String response = await rootBundle.loadString('Assets/json/cities.son');
    final data = await json.decode(response);
    for (int i = 0; i < data.length; i++) {

      citylist.add(citiesModel.fromJson(data[i]));
    }


    return citylist;
  }


}