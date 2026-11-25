import 'package:barber_booking_app/core/result/result.dart';
import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';

abstract interface class BookingRepository {
  Future<Result<List<BarberService>>> getServices();
  Future<Result<List<Appointment>>> getAppointments();

  Future<Result<Appointment>> createAppointment({
    required String barberId,
    required String serviceId,
    required String customerName,
    required String customerPhone,
    required DateTime startsAt,
  });

  Future<Result<bool>> cancelAppointment(String appointmentId);
}
