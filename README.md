# Barber Booking

Portfolio-grade barbershop scheduling built as a modular ASP.NET MVC monolith with a Flutter client.

## Technology

- ASP.NET MVC 5 and ASP.NET Web API 2 on .NET Framework 4.8
- Entity Framework 6 and SQL Server
- Flutter with feature-first Clean Architecture
- Cubit, GetIt + Injectable, Dio, GoRouter, ARB localization
- English and Brazilian Portuguese
- System, light, and dark theme modes

## Repository layout

```text
src/
  backend/  ASP.NET MVC modular monolith and versioned API
  mobile/   Flutter application
```

## Screenshots

| Booking | Appointment history | Settings |
| --- | --- | --- |
| ![Booking](docs/screenshots/booking.png) | ![Appointment history](docs/screenshots/history.png) | ![Settings](docs/screenshots/settings.png) |

## Architecture

The backend deploys as one application while keeping dependencies directed inward:

```text
Controller -> Application Service -> Domain Repository Contract
           -> Entity Framework Repository -> SQL Server
```

The Flutter application uses complete vertical slices:

```text
Page/Widget -> Cubit -> Use Case -> Repository Contract
            -> Repository Implementation -> Data Source -> API/storage
```

## Local setup

### Backend

1. Open `BarberBooking.sln` in Visual Studio.
2. Restore NuGet packages.
3. Update `BarberBookingConnection` in `src/backend/Web.config` if required.
4. Run the `BarberBooking.Backend` project with IIS Express.

LocalDB is the default development database. Entity Framework creates and seeds it on first use.

### Mobile

```bash
cd src/mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
adb reverse tcp:59579 tcp:59579
flutter run --dart-define=API_BASE_URL=http://localhost:59579/api/v1
```

Alternatively, Android emulators can access the host through `10.0.2.2`.

## Validation

```bash
flutter analyze
flutter test
```

Build the backend solution with Visual Studio or MSBuild for .NET Framework 4.8.

## Engineering conventions

All source code, identifiers, file names, folders, documentation, branches, and commit messages use English.
