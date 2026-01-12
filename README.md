# Habit Tracker Challenge App (تحدي العادات)

A beautiful habit tracking app with Arabic RTL support and English language options.

## Features

- 🌍 **Multi-language Support**: Arabic (RTL) and English
- 🎨 **Beautiful UI**: Modern, minimalist design with smooth animations
- 📝 **Onboarding Quiz**: 11-question personalized quiz
- 🎯 **Habit Challenges**: 7-day challenges to build positive habits
- 👥 **Friend Challenges**: Optional social features

## Folder Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       # Color constants
│   │   └── app_strings.dart      # String constants (AR/EN)
│   ├── theme/                    # Theme configuration
│   └── utils/                    # Utility functions
├── features/
│   ├── onboarding/
│   │   └── presentation/
│   │       └── screens/
│   │           ├── language_selection_screen.dart
│   │           ├── welcome_screen.dart
│   │           └── onboarding_quiz_screen.dart
│   └── auth/
│       └── presentation/
│           └── screens/
│               └── registration_screen.dart
└── main.dart
```

## Screens Flow

1. **Language Selection** → User selects Arabic or English
2. **Welcome Screen** → Beautiful intro with app branding
3. **Registration Screen** → Sign up options (Email, Google, Apple)
4. **Onboarding Quiz** → 11 personalized questions
5. **Summary Screen** → Personalized insights and first challenge

## Getting Started

### Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart 3.8.1 or higher

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- `google_fonts`: For Cairo and Inter fonts
- `shared_preferences`: For data persistence
- `smooth_page_indicator`: For quiz progress indicators

## Color Scheme

- **Primary Blue**: #4A90E2
- **Success Green**: #50C878
- **Background**: #FFF9F0 (Cream)
- **Welcome Blue**: #2563EB

## Fonts

- **Arabic**: Cairo
- **English**: Inter/Cairo

## License

This project is private and not licensed for public use.
