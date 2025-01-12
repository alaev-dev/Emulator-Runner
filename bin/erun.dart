import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:erun/android_command.dart';
import 'package:erun/iphone_command.dart';

const String version = '1.0.0';

void main(List<String> args) {
  final runner = CommandRunner('erun',
      'A CLI tool to launch iOS simulators and Android emulators with ease.')
    ..addCommand(IPhoneCommand())
    ..addCommand(AndroidCommand());

  runner.argParser.addFlag(
    'version',
    abbr: 'v',
    negatable: false,
    help: 'Print version information.',
  );

  // Handle version flag before running commands
  if (args.contains('-v') || args.contains('--version')) {
    print('erun version $version');
    return;
  }

  runner.run(args).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64); // 64 - usage error
  });
}
