import 'dart:convert';

class CityWeather {
  String cityName;
  double temperature;
  String weatherDescription;
  String iconCode;
  CityWeather({
    this.cityName,
    this.temperature,
    this.weatherDescription,
    this.iconCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'weatherDescription': weatherDescription,
      'iconCode': iconCode,
    };
  }

  factory CityWeather.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CityWeather(
      cityName: map['name'],
      temperature: map['main']['temp'].toDouble(),
      weatherDescription: map['weather'][0]['description'],
      iconCode: map['weather'][0]['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CityWeather.fromJson(String source) =>
      CityWeather.fromMap(json.decode(source));
}
