# 🌍 Country App

A Flutter application that lets users explore, search, sort, and manage country data with the ability to log in using Firebase Phone OTP authentication. The app also supports user profile management, dark mode, and seamless integration with REST APIs and Firestore.

---

## 🚀 Features

- 📞 **Phone OTP Authentication** (Firebase)
- 👤 **User Profile Management** with editable name, email, and image
- 📃 **List, Add, Edit, and Delete Custom Countries** (stored in Firestore)
- 🔍 **Search and Sort** Countries by population
- 🌙 **Light & Dark Theme Toggle** using GetX
- 📉 **REST API Integration** to fetch real country data
- 📊 **Firestore & Firebase Storage Integration**
- 📊 **Structured Folder Architecture** with clean modular code

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/                              # Core config (themes, routes, bindings)
│   ├── app_theme.dart
│   ├── constants.dart
│   ├── dependencies.dart
│   └── routes.dart
├── data/                              # Models, API, Firestore, and Repositories
│   ├── models/
│   │   ├── country_model.dart
│   │   ├── custom_country_model.dart
│   │   └── user_model.dart
│   ├── providers/
│   │   ├── api_provider.dart
│   │   └── firestore_provider.dart
│   └── repositories/
│       ├── auth_repository.dart
│       ├── country_repository.dart
│       └── user_repository.dart
├── modules/                           # App screens and controllers
│   ├── auth/                          # Login & OTP
│   ├── home/                          # Home, List, Add/Edit Country
│   └── profile/                       # Profile & Edit Profile
└── utils/                             # Reusable helpers, validators, extensions
```

---

## 🛠️ Tech Stack

- **Flutter** 3.10+
- **Firebase Auth & Firestore**
- **GetX** (State Management, Routing, Bindings)
- **REST Countries API** (https://restcountries.com)
- **Dark Mode** with ThemeController

---

## 🚲 Getting Started

```bash
git clone https://github.com/akiroy417/country_app.git
cd country_app
flutter pub get
flutter run
```

---

## 🔐 Firebase Setup

1. Enable **Phone Authentication** in Firebase Console.
2. Add:
    - `google-services.json` for Android in `/android/app`
    - `GoogleService-Info.plist` for iOS in `/ios/Runner`
3. Setup **Firestore** collections:
    - `users`
    - `customCountries`
4. Enable **Firebase Storage** for profile images.

---

## 📊 REST API Integration

- API Source: [REST Countries API](https://restcountries.com/v3.1/all)
- Integrated using `api_provider.dart` and managed via `country_repository.dart`

---

## 📸 Screenshots

> _Add screenshots or GIF demos of login, home, profile, add/edit country, etc._

---

## 📅 Upcoming Features

- Offline support with local caching
- Favorite countries functionality
- Localization (multi-language support)

---

## 💼 License

This project is licensed under the [MIT License](LICENSE).

---

## 📢 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

```bash
git checkout -b feature/your-feature-name
git commit -m "Add your message here"
git push origin feature/your-feature-name
```

---

## 🙏 Acknowledgements

- [Flutter](https://flutter.dev)
- [Firebase](https://firebase.google.com)
- [GetX](https://pub.dev/packages/get)
- [REST Countries API](https://restcountries.com)

---

