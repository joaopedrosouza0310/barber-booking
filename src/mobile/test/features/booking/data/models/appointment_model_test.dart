import 'package:barber_booking_app/features/booking/data/models/appointment_model.dart';
import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps an appointment payload into the domain entity', () {
    final appointment = AppointmentModel.fromJson({
      'id': 'appointment-1',
      'serviceId': 'service-1',
      'startsAt': '2026-11-25T13:00:00Z',
      'endsAt': '2026-11-25T13:45:00Z',
      'status': 'Scheduled',
    }).toDomain();

    expect(appointment.id, 'appointment-1');
    expect(appointment.serviceId, 'service-1');
    expect(appointment.startsAt, DateTime.utc(2026, 11, 25, 13));
    expect(appointment.endsAt, DateTime.utc(2026, 11, 25, 13, 45));
    expect(appointment.status, AppointmentStatus.scheduled);
  });

  test('maps cancelled appointments case-insensitively', () {
    final appointment = AppointmentModel.fromJson({
      'id': 'appointment-1',
      'serviceId': 'service-1',
      'startsAt': '2026-11-25T13:00:00Z',
      'endsAt': '2026-11-25T13:45:00Z',
      'status': 'CANCELLED',
    }).toDomain();

    expect(appointment.status, AppointmentStatus.cancelled);
  });
}
