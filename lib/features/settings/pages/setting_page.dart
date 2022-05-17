import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_video/app/widgets/primary_button.dart';
import 'package:project_video/features/settings/bloc/setting_bloc.dart';
import 'package:project_video/features/settings/bloc/setting_event.dart';
import 'package:project_video/features/settings/bloc/setting_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.arguments, Key? key}) : super(key: key);
  static const String routeName = '/settings';
  final SettingsArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
        lazy: false,
        create: (_) => SettingBloc()
          ..add(
            LoadNameEvent(arguments),
          ),
        child: SettingsPageContent(arguments: arguments));
  }
}

class SettingsPageContent extends StatefulWidget {
  const SettingsPageContent({required this.arguments, Key? key})
      : super(key: key);
  final SettingsArguments arguments;
  @override
  State<SettingsPageContent> createState() =>
      _SettingsPageState(arguments: arguments);
}

class _SettingsPageState extends State<SettingsPageContent> {
  final SettingsArguments arguments;

  _SettingsPageState({required this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<SettingBloc, SettingState>(
                buildWhen: (oldState, newState) =>
                    oldState.name != newState.name,
                builder: (context, state) {
                  return Text(state.name ?? '');
                }),
            PrimaryButton('Получить имя', onPressed: () {
              context.read<SettingBloc>().add(LoadNameEvent(arguments));
            }),
            PrimaryButton('Сохранить имя',
                onPressed: () => context
                    .read<SettingBloc>()
                    .add(SaveNameEvent(name: arguments.name))),
            PrimaryButton('Очистить имя',
                onPressed: () =>
                    context.read<SettingBloc>().add(ClearNameEvent())),
            ElevatedButton(
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(Icons.exit_to_app),
                  Text('Exit'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(Icons.arrow_back),
                  Text('Back'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsArguments {
  const SettingsArguments(this.name);

  final String name;
}
