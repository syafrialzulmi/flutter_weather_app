import 'package:equatable/equatable.dart';

class DirecGeocoding extends Equatable {
  const DirecGeocoding({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory DirecGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirecGeocoding(
        name: data['name'],
        country: data['country'],
        lat: data['lat'],
        lon: data['lon']);
  }

  final String name;
  final double lat;
  final double lon;
  final String country;

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  String toString() {
    return 'DirecGeocoding(name: $name, lat: $lat, lon: $lon, country: $country)';
  }
}
