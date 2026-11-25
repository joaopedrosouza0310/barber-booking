import 'package:barber_booking_app/core/result/result.dart';
import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';
import 'package:barber_booking_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:barber_booking_app/features/booking/domain/usecases/cancel_appointment.dart';
import 'package:barber_booking_app/features/booking/domain/usecases/create_appointment.dart';
import 'package:barber_booking_app/features/booking/domain/usecases/get_appointments.dart';
import 'package:barber_booking_app/features/booking/domain/usecases/get_services.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeBookingRepository repository;
  late BookingCubit cubit;

  setUp(() {
    repository = _FakeBookingRepository();
    cubit = BookingCubit(
      GetServices(repository),
      CreateAppointment(repository),
      GetAppointments(repository),
      CancelAppointment(repository),
    );
  });

  tearDown(() => cubit.close());

  test('loads services and appointment history', () async {
    await cubit.load();

    expect(cubit.state.servicesPhase, ServicesPhase.ready);
    expect(cubit.state.historyPhase, HistoryPhase.ready);
    expect(cubit.state.selectedService?.id, 'service-1');
    expect(cubit.state.appointments.single.id, 'appointment-1');
  });

  test('publishes confirmation and refreshes history after booking', () async {
    await cubit.load();

    await cubit.submit(
      name: 'Joao Pedro',
      phone: '99999999999',
      startsAt: DateTime.utc(2026, 11, 26, 13),
    );

    expect(cubit.state.bookingConfirmationVersion, 1);
    expect(cubit.state.isSubmitting, isFalse);
    expect(cubit.state.appointments, hasLength(2));
  });

  test('cancels an appointment and refreshes its status', () async {
    await cubit.load();

    await cubit.cancel('appointment-1');

    expect(cubit.state.cancellationVersion, 1);
    expect(cubit.state.cancellingAppointmentId, isNull);
    expect(cubit.state.appointments.single.status, AppointmentStatus.cancelled);
  });
}

final class _FakeBookingRepository implements BookingRepository {
  final services = const [
    BarberService(
      id: 'service-1',
      name: 'Classic haircut',
      durationMinutes: 45,
      price: 35,
    ),
  ];

  final appointments = <Appointment>[
    Appointment(
      id: 'appointment-1',
      serviceId: 'service-1',
      startsAt: DateTime.utc(2026, 11, 25, 13),
      endsAt: DateTime.utc(2026, 11, 25, 13, 45),
      status: AppointmentStatus.scheduled,
    ),
  ];

  @override
  Future<Result<List<BarberService>>> getServices() async => Success(services);

  @override
  Future<Result<List<Appointment>>> getAppointments() async =>
      Success(List.of(appointments));

  @override
  Future<Result<Appointment>> createAppointment({
    required String barberId,
    required String serviceId,
    required String customerName,
    required String customerPhone,
    required DateTime startsAt,
  }) async {
    final appointment = Appointment(
      id: 'appointment-2',
      serviceId: serviceId,
      startsAt: startsAt,
      endsAt: startsAt.add(const Duration(minutes: 45)),
      status: AppointmentStatus.scheduled,
    );
    appointments.add(appointment);
    return Success(appointment);
  }

  @override
  Future<Result<bool>> cancelAppointment(String appointmentId) async {
    final index = appointments.indexWhere(
      (appointment) => appointment.id == appointmentId,
    );
    final appointment = appointments[index];
    appointments[index] = Appointment(
      id: appointment.id,
      serviceId: appointment.serviceId,
      startsAt: appointment.startsAt,
      endsAt: appointment.endsAt,
      status: AppointmentStatus.cancelled,
    );
    return const Success(true);
  }
}
