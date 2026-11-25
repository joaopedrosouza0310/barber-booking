import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Barber Booking'**
  String get appName;

  /// No description provided for @navBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get navBook;

  /// No description provided for @navAppointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get navAppointments;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @bookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Book your next cut'**
  String get bookingTitle;

  /// No description provided for @bookingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A fresh look is only a few taps away.'**
  String get bookingSubtitle;

  /// No description provided for @bookingEyebrow.
  ///
  /// In en, this message translates to:
  /// **'YOUR NEXT VISIT'**
  String get bookingEyebrow;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesTitle;

  /// No description provided for @servicesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the experience that fits your day.'**
  String get servicesSubtitle;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTitle;

  /// No description provided for @customerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get customerNameLabel;

  /// No description provided for @customerPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get customerPhoneLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get chooseDate;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get chooseTime;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get bookNow;

  /// No description provided for @bookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Your appointment is confirmed.'**
  String get bookingConfirmed;

  /// No description provided for @appointmentHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your appointments'**
  String get appointmentHistoryTitle;

  /// No description provided for @appointmentHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review upcoming visits and previous bookings.'**
  String get appointmentHistorySubtitle;

  /// No description provided for @emptyAppointments.
  ///
  /// In en, this message translates to:
  /// **'No appointments yet'**
  String get emptyAppointments;

  /// No description provided for @emptyAppointmentsDescription.
  ///
  /// In en, this message translates to:
  /// **'Your confirmed bookings will appear here.'**
  String get emptyAppointmentsDescription;

  /// No description provided for @cancelAppointment.
  ///
  /// In en, this message translates to:
  /// **'Cancel appointment'**
  String get cancelAppointment;

  /// No description provided for @cancelAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this appointment?'**
  String get cancelAppointmentTitle;

  /// No description provided for @cancelAppointmentMessage.
  ///
  /// In en, this message translates to:
  /// **'This time will become available for another customer.'**
  String get cancelAppointmentMessage;

  /// No description provided for @keepAppointment.
  ///
  /// In en, this message translates to:
  /// **'Keep appointment'**
  String get keepAppointment;

  /// No description provided for @confirmCancellation.
  ///
  /// In en, this message translates to:
  /// **'Yes, cancel'**
  String get confirmCancellation;

  /// No description provided for @appointmentCancelled.
  ///
  /// In en, this message translates to:
  /// **'The appointment was cancelled.'**
  String get appointmentCancelled;

  /// No description provided for @cancellationError.
  ///
  /// In en, this message translates to:
  /// **'We could not cancel this appointment. Try again.'**
  String get cancellationError;

  /// No description provided for @statusScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get statusScheduled;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @statusNoShow.
  ///
  /// In en, this message translates to:
  /// **'No-show'**
  String get statusNoShow;

  /// No description provided for @appointmentTimeRange.
  ///
  /// In en, this message translates to:
  /// **'{start} – {end}'**
  String appointmentTimeRange(String start, String end);

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'Complete all fields before booking.'**
  String get validationRequired;

  /// No description provided for @loadingServices.
  ///
  /// In en, this message translates to:
  /// **'Loading services'**
  String get loadingServices;

  /// No description provided for @emptyServices.
  ///
  /// In en, this message translates to:
  /// **'No services are available right now.'**
  String get emptyServices;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;

  /// No description provided for @conflictError.
  ///
  /// In en, this message translates to:
  /// **'That time was just booked. Choose another time.'**
  String get conflictError;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String minutes(int count);

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'\${amount}'**
  String price(String amount);

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Make it yours'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how Barber Booking looks and speaks to you.'**
  String get settingsSubtitle;

  /// No description provided for @themeDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the appearance you prefer.'**
  String get themeDescription;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the language used throughout the app.'**
  String get languageDescription;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System theme'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get portuguese;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
