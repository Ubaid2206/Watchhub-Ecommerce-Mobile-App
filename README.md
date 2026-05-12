# WatchHub 🕰️

A comprehensive Flutter application designed for watch enthusiasts to explore, discover, and manage their favorite timepieces.

## 📱 Features

- Browse extensive watch collections
- Detailed watch specifications and reviews
- User-friendly interface with modern design
- Cross-platform support (Android & iOS)
- Responsive layout for different screen sizes

## 🛠️ Prerequisites

Before running this project, make sure you have the following installed:

- **Flutter SDK** (>=3.0.0)
- **Dart SDK** (>=2.17.0)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control
- **Android SDK** (for Android development)
- **Xcode** (for iOS development - macOS only)

## 📦 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ubaid2206/watchhub.git
   cd watchhub
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```

## 🚀 Running the App

### Development Mode
```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run with hot reload (default)
flutter run --hot
```

### Debug Mode
```bash
flutter run --debug
```

### Release Mode
```bash
flutter run --release
```

## 🔨 Build

### Android
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### iOS
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release
```

## 📁 Project Structure

```
watchhub/
├── lib/
│   ├── main.dart              # App entry point
│   ├── models/                # Data models
│   ├── screens/               # UI screens
│   ├── widgets/               # Reusable widgets
│   ├── services/              # API services
│   └── utils/                 # Utility functions
├── assets/
│   ├── images/                # Image assets
│   └── fonts/                 # Custom fonts
├── test/                      # Unit tests
├── android/                   # Android-specific code
├── ios/                       # iOS-specific code
└── pubspec.yaml              # Dependencies
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (iOS 11.0+)
- 🔄 Web (in development)
- 🔄 Desktop (planned)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/Ubaid2206)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Watch manufacturers for inspiration
- Open source community for valuable packages

## 📞 Support

If you have any questions or need help, please:

- Open an issue on GitHub
- Contact: your.email@example.com
- Join our Discord: [Discord Link]

## 🔄 Version History

- **v1.0.0** - Initial release
- **v0.1.0** - Beta version

---

**Made with ❤️ using Flutter**
