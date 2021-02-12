import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocWeatherDemo/data/data_model/weather_model.dart';
import 'package:blocWeatherDemo/data/data_repository/weather_data_repository.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  StreamSubscription streamSubscription;
  final Connectivity internetConnectivity;
  WeatherCubit({@required this.internetConnectivity}) : super(WeatherInitial());

  //Cubits
  void emitWeatherLoading() => emit(WeatherLoading());
  void emitWeatherLoaded({@required CityWeather cityWeather}) =>
      emit(WeatherLoaded(cityWeather: cityWeather));
  void emitWeatherLoadingError({@required String errorMessage}) =>
      emit(WeatherError(errorMessage: errorMessage));

//fetch cityWeatherData
  Future<void> loadCityWeather({@required String cityName}) async {
    var connectivityResult = await internetConnectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        WeatherDataRepository weatherDataRepository = WeatherDataRepository();
        emitWeatherLoading();
        final cityWeatherData =
            await weatherDataRepository.fetchCityWeather(cityName: cityName);
        emitWeatherLoaded(cityWeather: cityWeatherData);
      } on Exception {
        emitWeatherLoadingError(
            errorMessage: "failed to load weather data. Try again");
      }
    } else {
      emitWeatherLoadingError(errorMessage: "No internet connection");
    }
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
