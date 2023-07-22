import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.name,
    required this.country,
    required this.lastUpdate,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'][0];

    return Weather(
      description: weather['description'],
      icon: weather['icon'],
      temp: main['temp'],
      tempMax: main['temp_max'],
      tempMin: main['temp_min'],
      name: '',
      country: '',
      lastUpdate: DateTime.now(),
    );
  }

  factory Weather.initial() => Weather(
        description: '',
        icon: '',
        temp: 100,
        tempMax: 100,
        tempMin: 100,
        name: '',
        country: '',
        lastUpdate: DateTime(1970),
      );

  final String description;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String name;
  final String country;
  final DateTime lastUpdate;

  @override
  List<Object> get props {
    return [
      description,
      icon,
      temp,
      tempMin,
      tempMax,
      name,
      country,
      lastUpdate,
    ];
  }

  @override
  String toString() {
    return 'Weather(description: $description, icon: $icon, temp: $temp, tempMin: $tempMin, tempMax: $tempMax, name: $name, country: $country, lastUpdate: $lastUpdate)';
  }

  Weather copyWith({
    String? description,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? name,
    String? country,
    DateTime? lastUpdate,
  }) {
    return Weather(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}
