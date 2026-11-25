import 'package:barber_booking_app/core/result/result.dart';
import 'package:barber_booking_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CancelAppointment {
  CancelAppointment(this._repository);

  final BookingRepository _repository;

  Future<Result<bool>> call(String appointmentId) =>
      _repository.cancelAppointment(appointmentId);
}
