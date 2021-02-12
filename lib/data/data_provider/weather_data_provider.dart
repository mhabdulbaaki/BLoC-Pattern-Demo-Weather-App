import 'dart:convert' as convert;

import 'package:blocWeatherDemo/res/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//gets raw weather data from openWeather API

//"http://openweathermap.org/img/wn/${weatherIcon}@2x.png";
String weatherBaseURL = "http://api.openweathermap.org/data/2.5/weather?";

class WeatherDataProvider {
  Future<Map<String, dynamic>> getWeatherData(
      {@required String cityName}) async {
    final String url =
        weatherBaseURL + "q=$cityName&appid=$APIKey&units=metric";

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else
      throw Exception();
  }
}
