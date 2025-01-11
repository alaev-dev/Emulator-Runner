import 'package:args/command_runner.dart';
import 'package:erun/android_command.dart';
import 'package:erun/iphone_command.dart';

void main(List<String> args) {
  final runner = CommandRunner('erun',
      'A CLI tool to launch iOS simulators and Android emulators with ease.')
    ..addCommand(IPhoneCommand())
    ..addCommand(AndroidCommand());

  // Add global version flag
  runner.argParser.addFlag(
    'version',
    abbr: 'v',
    negatable: false,
    help: 'Print the current version.',
  );

  // Handle version flag and normal command execution
  runner.run(args).catchError((error) {
    if (error is! UsageException) throw error;

    final results = runner.argParser.parse(args);
    print(results.arguments);

    // Re-throw the error for other usage exceptions
    throw error;
  });
}
