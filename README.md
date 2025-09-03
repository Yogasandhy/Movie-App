# Movie App 🎬

A Flutter movie discovery app with clean architecture, built using TMDB API.

## Features

- Browse popular, top-rated, and now playing movies
- Search movies by title
- Filter movies by genre
- View detailed movie information
- Save favorite movies
- Clean and responsive UI

## Tech Stack

- **Flutter** - UI framework
- **Provider** - State management
- **Clean Architecture** - Code organization
- **TMDB API** - Movie data source

## Project Structure

```
lib/
├── core/                   # Core utilities
├── features/               # Business logic
│   └── movies/            # Movie feature
├── presentation/          # UI components
│   ├── pages/            # All screens
│   ├── providers/        # State management
│   └── widgets/          # Shared components
└── main.dart             # App entry point
```

## Getting Started

1. Clone the repository
```bash
git clone https://github.com/Yogasandhy/Movie-App.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```
Built with ❤️ using Flutter
