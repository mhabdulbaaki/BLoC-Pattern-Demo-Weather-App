import 'package:blocWeatherDemo/bloc/cubit/weather_cubit.dart';
import 'package:blocWeatherDemo/data/data_model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherSearchPage extends StatefulWidget {
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child:
            BlocConsumer<WeatherCubit, WeatherState>(builder: (context, state) {
          if (state is WeatherInitial) {
            return buildInitialInput();
          } else if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildColumnWithData(state.cityWeather);
          }
          return buildInitialInput();
        }, listener: (context, state) {
          if (state is WeatherError) {
            return Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        }),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  SingleChildScrollView buildColumnWithData(CityWeather weather) {
    return SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            weather.cityName,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            // Display the temperature with 1 decimal place
            "${weather.temperature.toStringAsFixed(1)} °C",
            style: TextStyle(fontSize: 80),
          ),
          Image.network(
              "http://openweathermap.org/img/wn/${weather.iconCode}@2x.png"),
          CityInputField(),
        ],
      ),
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) async {
    final weatherCubit = BlocProvider.of<WeatherCubit>(context);
    await weatherCubit.loadCityWeather(cityName: cityName);
  }
}
