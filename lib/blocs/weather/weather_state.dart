part of 'weather_bloc.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  const WeatherState({
    required this.error,
    required this.status,
    required this.weather,
  });

  factory WeatherState.initial() {
    return WeatherState(
      status: WeatherStatus.initial,
      weather: Weather.initial(),
      error: const CustomError(),
    );
  }

  final CustomError error;
  final WeatherStatus status;
  final Weather weather;

  @override
  List<Object> get props => [error, status, weather];

  @override
  String toString() =>
      'WeatherState(error: $error, status: $status, weather: $weather)';

  WeatherState copyWith({
    CustomError? error,
    WeatherStatus? status,
    Weather? weather,
  }) {
    return WeatherState(
      error: error ?? this.error,
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }
}
