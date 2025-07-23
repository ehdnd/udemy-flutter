# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter meals app built as part of a Udemy course. It displays meal categories in a grid layout and allows navigation to individual meal listings. The app uses Material Design with a dark theme and Google Fonts (Lato).

## Common Development Commands

### Running the App
```bash
flutter run
```

### Development Tools
```bash
flutter analyze          # Static analysis and linting
flutter test            # Run tests (no tests currently present)
flutter pub get         # Install dependencies
flutter pub upgrade     # Upgrade dependencies
flutter clean           # Clean build artifacts
flutter build apk       # Build Android APK
flutter build ios       # Build iOS app
```

### Platform-Specific Builds
```bash
flutter run -d chrome     # Run in web browser
flutter run -d windows    # Run on Windows desktop
flutter run -d macos      # Run on macOS desktop
flutter run -d linux      # Run on Linux desktop
```

## Architecture & Code Structure

### Project Organization
- `lib/main.dart` - App entry point with MaterialApp and theme configuration
- `lib/screens/` - Screen widgets (CategoriesScreen, MealsScreen)
- `lib/widgets/` - Reusable UI components (CategoryGridItem)
- `lib/models/` - Data models (Category, Meal with enums for Complexity/Affordability)
- `lib/data/` - Static data (dummy_data.dart with categories and meals)

### Key Design Patterns
- **Screen Navigation**: Uses Navigator.push with MaterialPageRoute for screen transitions
- **Data Models**: Immutable classes with const constructors for Category and Meal
- **State Management**: Currently uses StatelessWidget throughout (no complex state management)
- **Theming**: Global dark theme with Material 3 ColorScheme.fromSeed

### Navigation Flow
1. CategoriesScreen (main.dart:23) - Grid of meal categories
2. MealsScreen - Lists meals for selected category (currently shows empty state)

### Dependencies
- `google_fonts: ^6.2.1` - Lato font family for text theme
- `cupertino_icons: ^1.0.8` - iOS-style icons
- `flutter_lints: ^5.0.0` - Dart/Flutter linting rules

### Current Development State
- Basic category grid display is implemented
- Meal detail screen exists but shows placeholder content
- Navigation between screens is functional but incomplete
- No meal filtering by category is implemented yet
- No meal detail view exists

### Code Conventions
- Uses trailing commas (configured in analysis_options.yaml)
- Follows Flutter lints package recommendations
- Const constructors for immutable widgets and models
- lowerCamelCase for constants (as noted in dummy_data.dart:6)