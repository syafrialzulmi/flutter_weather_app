class WeatherException implements Exception {
  WeatherException([this.message = 'Something when wrong']) {
    message = 'Weather Exception : $message';
  }

  String message;

  @override
  String toString() {
    return message;
  }
}
