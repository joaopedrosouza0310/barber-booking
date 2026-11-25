import 'package:barber_booking_app/core/result/result.dart';
import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:barber_booking_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAppointments {
  GetAppointments(this._repository);

  final BookingRepository _repository;

  Future<Result<List<Appointment>>> call() => _repository.getAppointments();
}
