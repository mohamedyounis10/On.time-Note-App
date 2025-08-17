# 📱 on.time - Smart Task Management App

A modern Flutter application that combines calendar scheduling with intelligent note-taking for efficient task management.

## ✨ Features

- **📅 Dual View System**: Switch between Schedule and Notes modes
- **🗓️ Smart Calendar**: Interactive calendar with future-only date selection
- **📝 Quick Notes**: Create tasks with automatic timestamps
- **✅ Task Management**: Check/uncheck tasks with visual feedback
- **🗑️ Easy Delete**: Remove tasks with confirmation
- **🎨 Beautiful UI**: Dark theme with purple gradients
- **📱 Responsive Design**: Adapts to any screen size

## 🛠️ Built With

- **Flutter** - Cross-platform UI framework
- **BLoC Pattern** - State management
- **ScreenUtil** - Responsive design
- **TableCalendar** - Calendar integration
- **Intl** - Date formatting

## 📸 Screenshots

[Add your app screenshots here]

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/on.time.git
```

2. Navigate to the project directory
```bash
cd on.time
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── app_color.dart      # Shared colors and styles
│   ├── app_padding.dart    # Shared padding constants
│   └── schedule_card.dart  # Schedule card widget
├── cubit/
│   ├── logic.dart          # Business logic
│   └── state.dart          # State definitions
├── features/
│   └── ui/
│       ├── home_page.dart  # Main screen
│       ├── note_screen.dart # Note creation screen
│       └── splash_screen.dart # Splash screen
├── models/
│   └── task.dart           # Task model
└── main.dart               # App entry point
```

## 🎯 Usage

1. **Schedule Mode**: View tasks in calendar format with timeline
2. **Notes Mode**: Create and manage tasks in list format
3. **Add Task**: Tap the + button to create new tasks
4. **Complete Task**: Check/uncheck tasks to mark completion
5. **Delete Task**: Use the delete icon to remove tasks

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC pattern for state management
- TableCalendar package for calendar functionality

---

⭐ **Star this repository if you found it helpful!**
