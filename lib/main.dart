import 'package:blocWeatherDemo/UI/home_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cubit/weather_cubit.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  MyApp({@required this.connectivity});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Weather Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<WeatherCubit>(
        create: (context) => WeatherCubit(internetConnectivity: connectivity),
        child: WeatherSearchPage(),
      ),
    );
  }
}
