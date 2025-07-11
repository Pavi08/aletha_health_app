# aletha_health_exercise

## Aletha Health – Exercise App

A mobile exercise app built with Flutter and Dart to help users improve their physical well-being by performing guided workouts. This app retrieves exercises from a REST API and allows users to start a timer, complete exercises, and track progress including daily streaks.

---

### 📱 2.1 About the App

The Aletha Health Exercise App allows users to:

- Browse a list of exercises with their names and durations.
- View detailed information about each exercise, including its description and difficulty.
- Start an in-app timer to perform the exercise.
- Get notified when the exercise is complete.
- Track completion status locally.
- View a streak tracker showing how many continuous days they’ve completed at least one exercise. *(optional)*

---

### 🏗️ 2.2 Architecture

The app follows Clean Architecture principles and is modularized into three layers:

#### 1. Presentation Layer
- UI Widgets
- Bloc-based State Management
- Uses `flutter_bloc` to handle UI updates, events, and transitions.

#### 2. Domain Layer
- Entities: Plain models like `Exercise`.
- Use Cases: Business logic, like tracking streaks.

#### 3. Data Layer
- Repositories and Data Sources.
- Uses `dio` for API requests.
- Local persistence using `shared_preferences` to track completed exercises.

---

### 🔄 Navigation

- Uses native `Navigator` with `MaterialPageRoute` for simplicity.
- Passes exercise objects between screens directly as constructor arguments.

---

### ⚠️ 2.3 Known Shortcomings or Errors

- Exercise completion is tracked locally; not synced with a backend.
- App assumes API is always available (limited offline support).
- Streak tracking is optional and may be reset on uninstall or reinstall.

---

### 🚀 2.4 How to Run the App

#### Prerequisites:
- Flutter SDK (>=3.6.0)
- Dart
- IDE: Android Studio or VS Code

#### Steps:

**Clone the Repo**
```bash
git clone https://github.com/Pavi08/aletha_health_app.git
cd aletha_health_app
flutter pub get
flutter run
flutter run --hot
