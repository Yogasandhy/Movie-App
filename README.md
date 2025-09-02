# Movie App 🎬

A modern Flutter application for discovering and exploring movies using The Movie Database (TMDB) API.

## Features ✨

- **Browse Movies**: Discover popular, top-rated, and now playing movies
- **Movie Details**: View comprehensive movie information with ratings and overview
- **Search Movies**: Find your favorite movies quickly
- **Genre Categories**: Filter movies by genre (Action, Romance, Comedy, Horror, Drama)
- **Modern UI**: Clean and responsive design with smooth animations
- **Movie Collections**: See all movies in organized collections

## Screenshots 📱

The app features a modern dark theme with:
- Clean navigation with bottom tabs
- Featured movie carousel
- Grid and list movie layouts
- Detailed movie information screens

## Tech Stack 🛠️

- **Framework**: Flutter
- **State Management**: Provider
- **API**: The Movie Database (TMDB)
- **HTTP Client**: http package
- **UI Components**: Material Design 3

## API Setup 🔑

This app uses TMDB API. To run the project:

1. Get your API key from [TMDB](https://www.themoviedb.org/settings/api)
2. The API key is already configured in the project files

## Getting Started 🚀

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

## Project Structure 📁

```
lib/
├── Detail/          # Movie detail screens and providers
├── Genre/           # Genre filtering functionality
├── Home/            # Home screen and movie lists
├── Search/          # Search functionality
├── bottomnavbar.dart # Bottom navigation
├── main.dart        # App entry point
└── movie_model.dart # Data models
```

## Contributing 🤝

Feel free to fork this project and submit pull requests for any improvements.

## License 📄

This project is open source and available under the [MIT License](LICENSE).

---

Built with ❤️ using Flutter
