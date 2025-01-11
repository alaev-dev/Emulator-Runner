# erun

🚀 Supercharge your mobile development workflow with this powerful CLI tool. Launch iOS simulators and Android emulators with a single command - no more clicking through endless menus!

## Installation

### Using Homebrew (recommended)
```bash
brew install erun
```

### Manual Installation
1. Make sure you have Dart SDK installed
2. Clone this repository
3. Run `dart pub get` to install dependencies
4. Run `dart pub global activate --source path .` from the project directory

## Requirements

### For iOS Development
- Xcode and iOS Simulator installed
- Xcode Command Line Tools (`xcode-select --install`)

### For Android Development
- Android SDK installed
- At least one Android Virtual Device (AVD) created
- `ANDROID_HOME` environment variable set
- Android SDK tools in your PATH (`emulator` and `adb` commands available)

## Usage

### Launch iOS Simulator

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
- `-y, --run`: Automatically run Flutter app after device launches

## Common Issues

### iOS
- If you get "xcrun not found" error, install Xcode Command Line Tools
- Make sure you have at least one iOS Simulator created in Xcode

### Android
- If "emulator not found", check if Android SDK tools are in your PATH
- Ensure you have created AVDs using Android Studio

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details
