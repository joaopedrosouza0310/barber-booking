import 'package:barber_booking_app/core/error/app_failure.dart';
import 'package:barber_booking_app/core/result/result.dart';
import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';
import 'package:barber_booking_app/features/booking/domain/usecases/cancel_appointment.dart';
import 'package:barber_booking_app/features/booking/domain/usecases/create_appointment.dart';
import 'package:barber_booking_app/features/booking/domain/usecases/get_appointments.dart';
import 'package:barber_booking_app/features/booking/domain/usecases/get_services.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  BookingCubit(
    this._getServices,
    this._createAppointment,
    this._getAppointments,
    this._cancelAppointment,
  ) : super(const BookingState());

  static const defaultBarberId = 'c14c50cd-dcb6-418a-b4a1-6029e57efe82';
  final GetServices _getServices;
  final CreateAppointment _createAppointment;
  final GetAppointments _getAppointments;
  final CancelAppointment _cancelAppointment;

  Future<void> load() async {
    await loadServices();
    await loadAppointments();
  }

  Future<void> loadServices() async {
    if (state.servicesPhase == ServicesPhase.loading) return;
    emit(
      state.copyWith(servicesPhase: ServicesPhase.loading, clearFailure: true),
    );
    switch (await _getServices()) {
      case Success(value: final services):
        emit(
          state.copyWith(
            servicesPhase: services.isEmpty
                ? ServicesPhase.empty
                : ServicesPhase.ready,
            services: services,
            selectedService: services.isEmpty ? null : services.first,
            clearFailure: true,
          ),
        );
      case FailureResult(failure: final failure):
        emit(
          state.copyWith(
            servicesPhase: ServicesPhase.failure,
            failure: failure,
          ),
        );
    }
  }

  Future<void> loadAppointments() async {
    if (state.historyPhase == HistoryPhase.loading) return;
    emit(
      state.copyWith(
        historyPhase: HistoryPhase.loading,
        clearHistoryFailure: true,
      ),
    );
    switch (await _getAppointments()) {
      case Success(value: final appointments):
        emit(
          state.copyWith(
            historyPhase: appointments.isEmpty
                ? HistoryPhase.empty
                : HistoryPhase.ready,
            appointments: appointments,
            clearHistoryFailure: true,
          ),
        );
      case FailureResult(failure: final failure):
        emit(
          state.copyWith(
            historyPhase: HistoryPhase.failure,
            historyFailure: failure,
          ),
        );
    }
  }

  void selectService(BarberService service) {
    if (state.isSubmitting) return;
    emit(state.copyWith(selectedService: service, clearFailure: true));
  }

  Future<void> submit({
    required String name,
    required String phone,
    required DateTime startsAt,
  }) async {
    final service = state.selectedService;
    if (service == null || state.isSubmitting) return;
    if (name.trim().length < 2 || phone.trim().length < 8) {
      emit(
        state.copyWith(
          failure: const AppFailure(FailureKind.validation),
          isSubmitting: false,
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true, clearFailure: true));
    switch (await _createAppointment(
      barberId: defaultBarberId,
      serviceId: service.id,
      customerName: name.trim(),
      customerPhone: phone.trim(),
      startsAt: startsAt,
    )) {
      case Success():
        emit(
          state.copyWith(
            isSubmitting: false,
            selectedService: state.services.isEmpty
                ? service
                : state.services.first,
            bookingConfirmationVersion: state.bookingConfirmationVersion + 1,
            clearFailure: true,
          ),
        );
        await loadAppointments();
      case FailureResult(failure: final failure):
        emit(state.copyWith(isSubmitting: false, failure: failure));
    }
  }

  Future<void> cancel(String appointmentId) async {
    if (state.cancellingAppointmentId != null) return;
    emit(
      state.copyWith(
        cancellingAppointmentId: appointmentId,
        clearHistoryFailure: true,
      ),
    );
    switch (await _cancelAppointment(appointmentId)) {
      case Success():
        emit(
          state.copyWith(
            cancellationVersion: state.cancellationVersion + 1,
            clearCancellingAppointment: true,
          ),
        );
        await loadAppointments();
      case FailureResult(failure: final failure):
        emit(
          state.copyWith(
            historyFailure: failure,
            clearCancellingAppointment: true,
          ),
        );
    }
  }
}
