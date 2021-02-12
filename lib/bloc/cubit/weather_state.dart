part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final CityWeather cityWeather;
  const WeatherLoaded({@required this.cityWeather});
}

class WeatherError extends WeatherState {
  final String errorMessage;
  const WeatherError({@required this.errorMessage});
}
