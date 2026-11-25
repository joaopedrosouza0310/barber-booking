// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Barber Booking';

  @override
  String get navBook => 'Book';

  @override
  String get navAppointments => 'Appointments';

  @override
  String get navSettings => 'Settings';

  @override
  String get bookingTitle => 'Book your next cut';

  @override
  String get bookingSubtitle => 'A fresh look is only a few taps away.';

  @override
  String get bookingEyebrow => 'YOUR NEXT VISIT';

  @override
  String get servicesTitle => 'Services';

  @override
  String get servicesSubtitle => 'Choose the experience that fits your day.';

  @override
  String get scheduleTitle => 'Schedule';

  @override
  String get customerNameLabel => 'Your name';

  @override
  String get customerPhoneLabel => 'Phone number';

  @override
  String get dateLabel => 'Date';

  @override
  String get timeLabel => 'Time';

  @override
  String get chooseDate => 'Choose date';

  @override
  String get chooseTime => 'Choose time';

  @override
  String get bookNow => 'Book now';

  @override
  String get bookingConfirmed => 'Your appointment is confirmed.';

  @override
  String get appointmentHistoryTitle => 'Your appointments';

  @override
  String get appointmentHistorySubtitle =>
      'Review upcoming visits and previous bookings.';

  @override
  String get emptyAppointments => 'No appointments yet';

  @override
  String get emptyAppointmentsDescription =>
      'Your confirmed bookings will appear here.';

  @override
  String get cancelAppointment => 'Cancel appointment';

  @override
  String get cancelAppointmentTitle => 'Cancel this appointment?';

  @override
  String get cancelAppointmentMessage =>
      'This time will become available for another customer.';

  @override
  String get keepAppointment => 'Keep appointment';

  @override
  String get confirmCancellation => 'Yes, cancel';

  @override
  String get appointmentCancelled => 'The appointment was cancelled.';

  @override
  String get cancellationError =>
      'We could not cancel this appointment. Try again.';

  @override
  String get statusScheduled => 'Scheduled';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusNoShow => 'No-show';

  @override
  String appointmentTimeRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get validationRequired => 'Complete all fields before booking.';

  @override
  String get loadingServices => 'Loading services';

  @override
  String get emptyServices => 'No services are available right now.';

  @override
  String get retry => 'Try again';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get conflictError => 'That time was just booked. Choose another time.';

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String price(String amount) {
    return '\$$amount';
  }

  @override
  String get appearance => 'Appearance';

  @override
  String get settingsTitle => 'Make it yours';

  @override
  String get settingsSubtitle =>
      'Choose how Barber Booking looks and speaks to you.';

  @override
  String get themeDescription => 'Select the appearance you prefer.';

  @override
  String get languageDescription =>
      'Choose the language used throughout the app.';

  @override
  String get systemTheme => 'System theme';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Português';
}
