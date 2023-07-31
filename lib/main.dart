import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather_app/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:flutter_weather_app/blocs/theme/theme_bloc.dart';
import 'package:flutter_weather_app/blocs/weather/weather_bloc.dart';
import 'package:flutter_weather_app/ui/pages/home_page.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_weather_app/data/repositories/weather_repository.dart';
import 'package:flutter_weather_app/data/services/weather_api_services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          httpClient: http.Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsBloc>(
            create: (context) => TempSettingsBloc(),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
        ],
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            context.read<ThemeBloc>().setTheme(state.weather.temp);
          },
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: state.appTheme == AppTheme.light
                    ? ThemeData.light()
                    : ThemeData.dark(),
                home: const HomePage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
