import 'package:args/command_runner.dart';
import 'package:erun/android_command.dart';
import 'package:erun/iphone_command.dart';

void main(List<String> args) {
  final runner = CommandRunner('erun',
      'A CLI tool to launch iOS simulators and Android emulators with ease.')
    ..addCommand(IPhoneCommand())
    ..addCommand(AndroidCommand());

  runner.run(args);
}
