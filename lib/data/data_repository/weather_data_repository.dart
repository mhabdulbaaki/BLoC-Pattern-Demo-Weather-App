import 'package:blocWeatherDemo/data/data_model/weather_model.dart';
import 'package:blocWeatherDemo/data/data_provider/weather_data_provider.dart';
import 'package:flutter/foundation.dart';

class WeatherDataRepository {
  WeatherDataProvider weatherDataProvider = WeatherDataProvider();
  CityWeather cityWeather;
  Future<CityWeather> fetchCityWeather({@required String cityName}) async {
    try {
      final rawWeatherData =
          await weatherDataProvider.getWeatherData(cityName: cityName);
      cityWeather = CityWeather.fromMap(rawWeatherData);

      return cityWeather;
    } on Exception {
      throw Exception();
    }
  }
}
