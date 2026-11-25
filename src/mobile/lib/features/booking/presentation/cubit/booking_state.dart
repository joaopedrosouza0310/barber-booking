import 'package:barber_booking_app/core/error/app_failure.dart';
import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';

enum ServicesPhase { initial, loading, ready, empty, failure }

enum HistoryPhase { initial, loading, ready, empty, failure }

final class BookingState {
  const BookingState({
    this.servicesPhase = ServicesPhase.initial,
    this.historyPhase = HistoryPhase.initial,
    this.services = const [],
    this.appointments = const [],
    this.selectedService,
    this.failure,
    this.historyFailure,
    this.isSubmitting = false,
    this.cancellingAppointmentId,
    this.bookingConfirmationVersion = 0,
    this.cancellationVersion = 0,
  });

  final ServicesPhase servicesPhase;
  final HistoryPhase historyPhase;
  final List<BarberService> services;
  final List<Appointment> appointments;
  final BarberService? selectedService;
  final AppFailure? failure;
  final AppFailure? historyFailure;
  final bool isSubmitting;
  final String? cancellingAppointmentId;
  final int bookingConfirmationVersion;
  final int cancellationVersion;

  bool get canSubmit => selectedService != null && !isSubmitting;

  BookingState copyWith({
    ServicesPhase? servicesPhase,
    HistoryPhase? historyPhase,
    List<BarberService>? services,
    List<Appointment>? appointments,
    BarberService? selectedService,
    AppFailure? failure,
    AppFailure? historyFailure,
    bool? isSubmitting,
    String? cancellingAppointmentId,
    int? bookingConfirmationVersion,
    int? cancellationVersion,
    bool clearFailure = false,
    bool clearHistoryFailure = false,
    bool clearCancellingAppointment = false,
  }) => BookingState(
    servicesPhase: servicesPhase ?? this.servicesPhase,
    historyPhase: historyPhase ?? this.historyPhase,
    services: services ?? this.services,
    appointments: appointments ?? this.appointments,
    selectedService: selectedService ?? this.selectedService,
    failure: clearFailure ? null : failure ?? this.failure,
    historyFailure: clearHistoryFailure
        ? null
        : historyFailure ?? this.historyFailure,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    cancellingAppointmentId: clearCancellingAppointment
        ? null
        : cancellingAppointmentId ?? this.cancellingAppointmentId,
    bookingConfirmationVersion:
        bookingConfirmationVersion ?? this.bookingConfirmationVersion,
    cancellationVersion: cancellationVersion ?? this.cancellationVersion,
  );
}
