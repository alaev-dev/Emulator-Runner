import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';

class IPhoneCommand extends Command {
  @override
  final name = 'i';

  @override
  final description = 'Handles iPhone-related operations';

  @override
  FutureOr run() async {
    try {
      final simulatorPath = await _findSimulatorPath();
      final simulators = await _listSimulators(simulatorPath);

      if (simulators.isEmpty) {
        print('No iOS simulators found. '
            'Please create one using Xcode.');
        return;
      }

      _displaySimulators(simulators);
      final selectedIndex = await _getValidSimulatorSelection(simulators.length);

      if (selectedIndex == null) {
        print('Invalid selection. Operation cancelled.');
        return;
      }

      print('\nLaunching simulator: ${simulators[selectedIndex]}...');
      await _launchSimulator(simulators[selectedIndex]);
    } catch (e) {
      print('Error: ${e.toString()}');
      exit(1);
    }
  }

  Future<String> _findSimulatorPath() async {
    final result = await Process.run('which', ['xcrun'], runInShell: true);
    if (result.exitCode != 0) {
      throw 'Could not find "xcrun" in PATH. '
          'Make sure Xcode is installed and Command Line Tools are set up.';
    }
    return result.stdout.toString().trim();
  }

  Future<List<String>> _listSimulators(String xcrunPath) async {
    final result = await Process.run(
      'xcrun', 
      ['simctl', 'list', 'devices', 'available', '--json'],
      runInShell: true,
    );
    if (result.exitCode != 0) {
      throw 'Failed to list simulators: ${result.stderr}';
    }

    // Parse JSON output and extract device names
    final devices = result.stdout
        .toString()
        .split('\n')
        .where((line) => line.contains('name'))
        .map((line) => line.split('"')[3])
        .where((name) => name.isNotEmpty)
        .toList();

    return devices;
  }

  void _displaySimulators(List<String> simulators) {
    print('\nAvailable iOS Simulators:');
    for (int i = 0; i < simulators.length; i++) {
      print('[${i + 1}] ${simulators[i]}');
    }
  }

  Future<int?> _getValidSimulatorSelection(int maxSimulators) async {
    stdout.write('\nSelect simulator (1-$maxSimulators): ');
    final input = stdin.readLineSync()?.trim();

    if (input == null || input.isEmpty) return null;

    final selection = int.tryParse(input);
    if (selection == null || selection < 1 || selection > maxSimulators) {
      return null;
    }

    return selection - 1;
  }

  Future<void> _launchSimulator(String simulatorName) async {
    final result = await Process.run(
      'xcrun',
      ['simctl', 'boot', simulatorName],
      runInShell: true,
    );
    if (result.exitCode != 0) {
      throw 'Failed to launch simulator: ${result.stderr}';
    }

    // Open Simulator.app to display the booted device
    await Process.run(
      'open',
      ['-a', 'Simulator'],
      runInShell: true,
    );
  }
}
