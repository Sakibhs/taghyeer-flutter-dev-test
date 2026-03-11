# Clean Architecture Implementation

This project implements Clean Architecture pattern with BLoC state management and Dio for HTTP requests.

## Project Structure

```
lib/
├── core/
│   ├── error/
│   │   ├── failures.dart          # Abstract failure classes
│   │   └── exceptions.dart        # Concrete exception classes
│   ├── network/
│   │   └── network_info.dart      # Network connectivity checker
│   └── usecases/
│       └── usecase.dart           # Base use case interface
├── features/
│   └── auth/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── auth_remote_data_source.dart  # API calls with Dio
│       │   │   └── auth_local_data_source.dart   # SharedPreferences storage
│       │   ├── models/
│       │   │   ├── login_request_model.dart      # Request DTO
│       │   │   └── user_model.dart               # Response DTO
│       │   └── repositories/
│       │       └── auth_repository_impl.dart     # Repository implementation
│       ├── domain/
│       │   ├── entities/
│       │   │   └── user.dart                     # User entity
│       │   ├── repositories/
│       │   │   └── auth_repository.dart          # Repository interface
│       │   └── usecases/
│       │       ├── login_usecase.dart            # Login business logic
│       │       ├── logout_usecase.dart           # Logout business logic
│       │       └── check_auth_status_usecase.dart # Auto-login logic
│       └── presentation/
│           ├── bloc/
│           │   ├── auth_bloc.dart               # BLoC implementation
│           │   ├── auth_event.dart              # BLoC events
│           │   └── auth_state.dart              # BLoC states
│           ├── pages/
│           │   ├── splash_page.dart             # Splash/Auth check screen
│           │   ├── login_page.dart              # Login screen
│           │   └── home_page.dart               # Home screen
│           └── widgets/
│               └── login_form.dart              # Reusable login form
├── injection_container.dart    # Dependency injection setup
└── main.dart                   # App entry point
```

## Architecture Layers

### 1. **Domain Layer** (Business Logic)
- **Entities**: Pure Dart objects representing business models
- **Repositories**: Abstract interfaces defining data operations
- **Use Cases**: Single-responsibility business logic classes

### 2. **Data Layer** (Data Sources)
- **Models**: Data transfer objects that extend entities
- **Data Sources**: Remote (API) and local (cache) data sources
- **Repository Implementations**: Concrete implementations of domain repositories

### 3. **Presentation Layer** (UI)
- **BLoC**: State management following BLoC pattern
- **Pages**: Screen widgets
- **Widgets**: Reusable UI components

## Dependencies

- **flutter_bloc** & **bloc**: State management
- **equatable**: Value equality
- **dartz**: Functional programming (Either, Left, Right)
- **dio**: HTTP client for API requests
- **internet_connection_checker**: Network connectivity
- **get_it**: Dependency injection
- **shared_preferences**: Local storage for session persistence

## Features

✅ **Clean Architecture** with proper layer separation
✅ **BLoC Pattern** for state management
✅ **Dio** for HTTP requests
✅ **Network connectivity** checking
✅ **Error handling** with Either monad
✅ **Dependency injection** with GetIt
✅ **Local session storage** with SharedPreferences
✅ **Auto-login** on app restart
✅ **Logout** with cache clearing
✅ **Persistent authentication** state

## Login API

**Endpoint**: `POST https://dummyjson.com/auth/login`

**Headers**:
```
Content-Type: application/json
```

**Request Body**:
```json
{
  "username": "emilys",
  "password": "emilyspass",
  "expiresInMins": 30
}
```

**Response**: User object with access token

## How It Works

### Login Flow
1. **User Input** → UI (LoginForm widget)
2. **Event Dispatch** → BLoC receives `LoginRequested` event
3. **Use Case Execution** → BLoC calls `LoginUseCase`
4. **Repository Call** → Use case calls repository interface
5. **Data Source** → Repository calls `AuthRemoteDataSource` (Dio)
6. **API Request** → Dio makes HTTP POST to login endpoint
7. **Response Mapping** → JSON → UserModel → User entity
8. **Cache User** → Repository saves user data to SharedPreferences
9. **Result Handling** → Either<Failure, User> returned
10. **State Emission** → BLoC emits `Authenticated` or `AuthError` state
11. **UI Update** → BlocConsumer rebuilds UI and navigates to HomePage

### Auto-Login Flow (App Restart)
1. **App Launch** → SplashPage displayed
2. **Check Auth** → BLoC receives `AuthStatusChecked` event
3. **Use Case Call** → BLoC calls `CheckAuthStatusUseCase`
4. **Load Cache** → Repository reads from SharedPreferences
5. **State Emission** → BLoC emits `Authenticated` or `Unauthenticated`
6. **Navigation** → Redirect to HomePage (if user exists) or LoginPage

### Logout Flow
1. **User Action** → Logout button pressed
2. **Confirmation** → Dialog confirms logout intent
3. **Event Dispatch** → BLoC receives `LogoutRequested` event
4. **Use Case Call** → BLoC calls `LogoutUseCase`
5. **Clear Cache** → Repository removes user from SharedPreferences
6. **State Emission** → BLoC emits `Unauthenticated` state
7. **Navigation** → Redirect to LoginPage

## Dependency Injection

Uses **GetIt** for service locator pattern. All dependencies are registered in `injection_container.dart`:

- Factory: New instance each time (BLoC)
- LazySingleton: Single instance created on first use (Use cases, Repositories, Data sources)
- Singleton: Single instance created immediately (External dependencies)

## Key Principles

✅ **Separation of Concerns**: Each layer has distinct responsibilities
✅ **Dependency Inversion**: High-level modules don't depend on low-level modules
✅ **Single Responsibility**: Each class has one reason to change
✅ **Testability**: Easy to mock dependencies and test each layer
✅ **Maintainability**: Changes isolated to specific layers

## Running the App

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

3. Use demo credentials:
   - Username: `emilys`
   - Password: `emilyspass`

## Testing

Each layer can be tested independently:
- **Domain**: Test use cases with mocked repositories
- **Data**: Test repositories and data sources with mocked network
- **Presentation**: Test BLoC with mocked use cases
