import 'dart:io' show Platform;

class PlatformUtils {
  static bool get _isWindows => Platform.isWindows;
  static bool get _isMacOS => Platform.isMacOS;
  static bool get _isLinux => Platform.isLinux;

  static void validateIosSupport() {
    if (!_isMacOS) {
      throw UnsupportedError(
        'iOS simulator commands are only supported on macOS.\n'
        'You are currently running on ${_getCurrentPlatform()}.\n'
        'Please use Android emulator instead with: erun a',
      );
    }
  }

  static void validateAndroidSupport() {
    if (_isWindows) {
      _checkWindowsAndroidSetup();
    } else if (_isLinux) {
      _checkUnixAndroidSetup();
    } else if (_isMacOS) {
      _checkUnixAndroidSetup();
    }
  }

  static String _getCurrentPlatform() {
    if (_isWindows) return 'Windows';
    if (_isMacOS) return 'macOS';
    if (_isLinux) return 'Linux';
    return 'Unknown Platform';
  }

  static void _checkWindowsAndroidSetup() {
    final androidHome = Platform.environment['ANDROID_HOME'];
    if (androidHome == null) {
      throw StateError(
        'ANDROID_HOME environment variable is not set.\n'
        'Please ensure Android SDK is installed and ANDROID_HOME is set.',
      );
    }
  }

  static void _checkUnixAndroidSetup() {
    final androidHome = Platform.environment['ANDROID_HOME'];
    if (androidHome == null) {
      throw StateError(
        'ANDROID_HOME environment variable is not set.\n'
        'Please add the following to your shell profile:\n'
        'export ANDROID_HOME=/path/to/android/sdk\n'
        'export PATH=\$PATH:\$ANDROID_HOME/tools:\$ANDROID_HOME/platform-tools',
      );
    }
  }
}
