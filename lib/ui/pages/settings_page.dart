import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/temp_settings/temp_settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListTile(
        title: const Text("Temperature Unit"),
        subtitle: const Text("Celcius/ Fahrenheit (default: Celcius)"),
        trailing: Switch(
          value: context.watch<TempSettingsBloc>().state.tempUnit ==
              TempUnit.celcius,
          onChanged: (_) {
            context.read<TempSettingsBloc>().add(ToggleTempUnitEvent());
          },
        ),
      ),
    );
  }
}
