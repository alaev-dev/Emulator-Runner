import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

class AndroidCommand extends Command {
  @override
  final name = 'a';

  @override
  final description = 'Handles Android-related operations';

  @override
  FutureOr run() async {
    try {
      final emulatorPath = await _findEmulatorPath();
      final emulators = await _listEmulators(emulatorPath);

      if (emulators.isEmpty) {
        print('No Android emulators found. '
            'Please create one using Android Studio.');
        return;
      }

      _displayEmulators(emulators);
      final selectedIndex = await _getValidEmulatorSelection(emulators.length);

      if (selectedIndex == null) {
        print('Invalid selection. Operation cancelled.');
        return;
      }

      print('\nLaunching emulator: ${emulators[selectedIndex]}...');
      await _launchEmulator(emulators[selectedIndex]);
    } catch (e) {
      print('Error: ${e.toString()}');
      exit(1);
    }
  }

  Future<String> _findEmulatorPath() async {
    final result = await Process.run('which', ['emulator'], runInShell: true);
    if (result.exitCode != 0) {
      throw 'Could not find "emulator" in PATH. '
          'Make sure Android SDK is installed and added to your PATH.';
    }
    return result.stdout.toString().trim();
  }

  Future<List<String>> _listEmulators(String emulatorPath) async {
    final result =
        await Process.run(emulatorPath, ['-list-avds'], runInShell: true);
    if (result.exitCode != 0) {
      throw 'Failed to list emulators: ${result.stderr}';
    }
    return result.stdout
        .toString()
        .trim()
        .split('\n')
        .where((e) => e.isNotEmpty)
        .toList();
  }

  void _displayEmulators(List<String> emulators) {
    print('\nAvailable Android Emulators:');
    for (int i = 0; i < emulators.length; i++) {
      print('[${i + 1}] ${emulators[i]}');
    }
  }

  Future<int?> _getValidEmulatorSelection(int maxEmulators) async {
    stdout.write('\nSelect emulator (1-$maxEmulators): ');
    final input = stdin.readLineSync()?.trim();

    if (input == null || input.isEmpty) return null;

    final selection = int.tryParse(input);
    if (selection == null || selection < 1 || selection > maxEmulators) {
      return null;
    }

    return selection - 1;
  }

  Future<void> _launchEmulator(String emulatorName) async {
    try {
      await Process.start('emulator', ['-avd', emulatorName]);
      // Don't wait for the process to complete since emulator runs continuously
      exit(0); // Exit successfully after launching
    } catch (e) {
      throw 'Failed to launch emulator: $e';
    }
  }
}
