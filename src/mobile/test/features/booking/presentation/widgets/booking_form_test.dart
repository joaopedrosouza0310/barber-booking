import 'package:barber_booking_app/features/booking/presentation/widgets/booking_form.dart';
import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('clears customer fields when a booking is confirmed', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(confirmationVersion: 0));

    await tester.enterText(
      find.widgetWithText(TextField, 'Your name'),
      'Joao Pedro',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Phone number'),
      '99999999999',
    );

    await tester.pumpWidget(_testApp(confirmationVersion: 1));
    await tester.pump();

    final fields = tester
        .widgetList<TextField>(find.byType(TextField))
        .toList();
    expect(fields[0].controller?.text, isEmpty);
    expect(fields[1].controller?.text, isEmpty);
  });
}

Widget _testApp({required int confirmationVersion}) {
  return MaterialApp(
    locale: const Locale('en'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(
      body: SingleChildScrollView(
        child: BookingForm(
          key: ValueKey(confirmationVersion),
          isSubmitting: false,
          onSubmit: (_, _, _) async {},
        ),
      ),
    ),
  );
}
