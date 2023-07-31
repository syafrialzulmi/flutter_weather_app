import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather_app/constants/constants.dart';
import 'package:flutter_weather_app/data/models/direct_geocoding.dart';
import 'package:flutter_weather_app/data/models/weather.dart';
import 'package:flutter_weather_app/data/services/http_error_handler.dart';
import 'package:flutter_weather_app/exceptions/weather_exception.dart';
import 'package:http/http.dart' as http;

class WeatherApiServices {
  WeatherApiServices({
    required this.httpClient,
  });

  final http.Client httpClient;

  Future<DirecGeocoding> getDirectGeocoding(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kAPiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw httpErrorHandles(response);
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the location of $city');
      }

      final directGeocoding = DirecGeocoding.fromJson(responseBody);

      return directGeocoding;
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(DirecGeocoding directGeocoding) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kAPiHost,
      path: 'data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lon}',
        'appid': dotenv.env['APPID']
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);

      final weatherJson = json.decode(response.body);
      print(weatherJson);

      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
