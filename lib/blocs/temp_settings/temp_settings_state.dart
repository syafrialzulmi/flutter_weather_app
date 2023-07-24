part of 'temp_settings_bloc.dart';

enum TempUnit {
  celcius,
  fahrenheit,
}

class TempSettingsState extends Equatable {
  const TempSettingsState({
    this.tempUnit = TempUnit.celcius,
  });

  factory TempSettingsState.initial() {
    return const TempSettingsState();
  }

  final TempUnit tempUnit;

  @override
  List<Object> get props => [tempUnit];

  @override
  String toString() => 'TempSettingsState(tempUnit: $tempUnit)';

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
