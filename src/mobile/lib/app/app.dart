import 'package:barber_booking_app/app/locale_cubit.dart';
import 'package:barber_booking_app/core/di/injection.dart';
import 'package:barber_booking_app/core/router/app_router.dart';
import 'package:barber_booking_app/core/theme/app_theme.dart';
import 'package:barber_booking_app/core/theme/theme_cubit.dart';
import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BarberBookingApp extends StatelessWidget {
  const BarberBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ThemeCubit>()),
        BlocProvider.value(value: getIt<LocaleCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) => BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
            routerConfig: appRouter,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      ),
    );
  }
}
