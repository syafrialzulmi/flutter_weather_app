import 'package:flutter_weather_app/data/models/custom_error.dart';
import 'package:flutter_weather_app/data/models/direct_geocoding.dart';
import 'package:flutter_weather_app/data/models/weather.dart';
import 'package:flutter_weather_app/data/services/weather_api_services.dart';
import 'package:flutter_weather_app/exceptions/weather_exception.dart';

class WeatherRepository {
  WeatherRepository({
    required this.weatherApiServices,
  });
  final WeatherApiServices weatherApiServices;

  fetchWeather(String city) async {
    try {
      final DirecGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);

      final Weather tmpWeather =
          await weatherApiServices.getWeather(directGeocoding);

      final Weather weather = tmpWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
