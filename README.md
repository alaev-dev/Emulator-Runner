# erun

🚀 Supercharge your mobile development workflow with this powerful CLI tool. Launch iOS simulators and Android emulators with a single command - no more clicking through endless menus!

[![CI/CD](https://github.com/alaev-dev/erun/actions/workflows/ci.yml/badge.svg)](https://github.com/alaev-dev/erun/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Installation

### macOS

#### Using Homebrew (recommended)
```bash
git clone git@github.com:alaev-dev/erun.git
cd erun
brew install --build-from-source $(pwd)/Formula/erun.rb
```

#### Manual Installation
1. Download the latest `erun-macos` from the [Releases](https://github.com/alaev-dev/erun/releases) page
2. Make it executable: `chmod +x erun-macos`
3. Move to a directory in your PATH: `sudo mv erun-macos /usr/local/bin/erun`

### Linux
1. Download the latest `erun-linux` from the [Releases](https://github.com/alaev-dev/erun/releases) page
2. Make it executable: `chmod +x erun-linux`
3. Move to a directory in your PATH: `sudo mv erun-linux /usr/local/bin/erun`

### Windows
1. Download the latest `erun-windows.exe` from the [Releases](https://github.com/alaev-dev/erun/releases) page
2. Rename it to `erun.exe`
3. Move it to a directory in your PATH or create a new directory and add it to your PATH

### Build from Source
1. Make sure you have Dart SDK installed
2. Clone this repository
3. Run `dart pub get` to install dependencies
4. Run `dart compile exe bin/erun.dart -o erun`

## Platform Support

| Feature | macOS | Windows | Linux |
|---------|-------|---------|--------|
| iOS Simulator | ✅ | ❌ | ❌ |
| Android Emulator | ✅ | ✅ | ✅ |

## Requirements

### For iOS Development (macOS only)
- Xcode and iOS Simulator installed
- Xcode Command Line Tools (`xcode-select --install`)

### For Android Development (all platforms)
- Android SDK installed
- At least one Android Virtual Device (AVD) created
- `ANDROID_HOME` environment variable set
- Android SDK tools in your PATH (`emulator` and `adb` commands available)

## Usage

### Launch iOS Simulator (macOS only)

```bash
erun i # Launch iOS simulator
erun i -y # Launch iOS simulator and run Flutter app
```

### Launch Android Emulator

```bash
erun a # Launch Android emulator
erun a -y # Launch Android emulator and run Flutter app
```

### Options
- `-v, --version`: Print version information
- `-h, --help`: Print usage information

## Common Issues

### iOS (macOS only)
- If you get "xcrun not found" error, install Xcode Command Line Tools
- Make sure you have at least one iOS Simulator created in Xcode

### Android
- If "emulator not found", check if Android SDK tools are in your PATH
- Ensure you have created AVDs using Android Studio
- On Windows, make sure to add `%ANDROID_HOME%\tools` and `%ANDROID_HOME%\platform-tools` to your PATH
- On Linux/macOS, add `$ANDROID_HOME/tools` and `$ANDROID_HOME/platform-tools` to your PATH

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Development

To run tests:
```bash
dart test
```

To format code:
```bash
dart format .
```

To analyze code:
```bash
dart analyze
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details