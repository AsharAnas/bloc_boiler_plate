# Bloc Boilerplate

Flutter app boilerplate with **BLoC** state management, **Dio** for API calls, and structured error handling. Kept simple and scalable.

## Structure

```
lib/
├── main.dart                 # Entry point
├── app.dart                  # MaterialApp (uses AppColors)
├── core/                     # Shared, app-wide code
│   ├── constants/
│   │   ├── api_constants.dart   # Base URL, timeouts
│   │   ├── endpoints.dart      # All API paths (add new here)
│   │   └── app_spacing.dart    # Padding, radius, icon sizes
│   ├── theme/
│   │   └── app_colors.dart     # Centralized colors → theme
│   ├── extensions/             # Custom extensions (import core/extensions/extensions.dart)
│   │   ├── context_extensions.dart  # theme, snackbar, hideKeyboard, screenSize
│   │   ├── string_extensions.dart    # capitalize, titleCase, isNullOrBlank
│   │   └── widget_extensions.dart    # paddingX/Y/All, centered, horizontalSpace
│   ├── widgets/                # Reusable UI (import core/widgets/app_widgets.dart)
│   │   ├── app_error_widget.dart    # Error + optional retry
│   │   ├── app_loader.dart          # AppLoader, AppLoaderInline
│   │   └── app_empty_widget.dart    # Empty state + optional action
│   ├── errors/
│   │   ├── app_exception.dart  # Exceptions (Network, Server, …)
│   │   └── failures.dart       # UI failures + exceptionToFailure()
│   └── network/
│       ├── dio_client.dart     # Dio + mapDioException (uses StatusCodeHandler for message)
│       ├── api_client.dart     # get/post/put/delete
│       ├── api_result.dart     # ApiSuccess | ApiFailure; use fold() in BLoC
│       ├── response_parser.dart # response.asList(fromJson), asObject(fromJson)
│       ├── status_code_handler.dart # messageFor(code); onStatusCode for 401
│       └── api_interceptor.dart # Auth headers; onError → StatusCodeHandler
├── data/
│   ├── models/                  # DTOs / entities
│   └── repositories/
│       ├── base_repository.dart # runCatching → ApiResult<T>
│       └── sample_repository.dart
└── presentation/
    └── home/
        ├── bloc/                # home_event, home_state, home_bloc
        └── pages/
            └── home_page.dart
```

## Flow

1. **UI** → dispatches events to **BLoC**.
2. **BLoC** → calls **Repository**.
3. **Repository** (extends `BaseRepository`) → uses `runCatching` + `ApiClient` + `response.asList(fromJson)` / `asObject(fromJson)`; returns `ApiResult<T>` (no manual type/parsing in repo).
4. **BLoC** → `result.fold((data) => emit(Loaded(data)), (failure) => emit(Error(failure)))`.
5. **UI** → `BlocBuilder` uses `AppLoader`, `AppErrorWidget`, `AppEmptyWidget` for loading/error/empty.

## Adding a feature

1. **Data:** Add model in `data/models/`, repository in `data/repositories/` (extend `BaseRepository`, use `runCatching` + `ApiClient` + `response.asList(Model.fromJson)` or `response.asObject(Model.fromJson)`; return `ApiResult<T>`).
2. **Presentation:** Create a folder e.g. `presentation/feature_name/` with `bloc/` (event, state, bloc) and `pages/`.
3. **Errors:** Use existing `AppException`/`Failure` types; add new ones in `core/errors/` only if needed.

## Config

- **Base URL:** `api_constants.dart` or `--dart-define=API_BASE_URL=...`
- **Endpoints:** `endpoints.dart` — `Endpoints.posts`, `Endpoints.postById(id)`
- **Colors / spacing:** `app_colors.dart`, `app_spacing.dart`
- **Extensions / widgets:** `core/extensions/extensions.dart`, `core/widgets/app_widgets.dart`
- **Repos:** Return `ApiResult<T>`; in BLoC use `result.fold((data) => emit(Loaded(data)), (f) => emit(Error(f)))`. Parse with `response.asList(Model.fromJson)` or `response.asObject(Model.fromJson)`.
- **Status codes:** `StatusCodeHandler.messageFor(code)` for default messages. Set `StatusCodeHandler.onStatusCode = (code) { ... }` in `main()` for 401 etc.
- **Auth:** In `api_interceptor.dart` → `onRequest`: `options.headers['Authorization'] = 'Bearer $token'`

## Run

```bash
flutter pub get
flutter run
```

The sample home screen loads posts from JSONPlaceholder; use the FAB to refresh. Errors (e.g. no network) are shown via the shared error UI.
