import 'package:barber_booking_app/core/result/result.dart';
import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:barber_booking_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateAppointment {
  CreateAppointment(this._repository);
  final BookingRepository _repository;

  Future<Result<Appointment>> call({
    required String barberId,
    required String serviceId,
    required String customerName,
    required String customerPhone,
    required DateTime startsAt,
  }) => _repository.createAppointment(
    barberId: barberId,
    serviceId: serviceId,
    customerName: customerName,
    customerPhone: customerPhone,
    startsAt: startsAt,
  );
}
