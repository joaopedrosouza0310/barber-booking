import 'package:barber_booking_app/core/result/result.dart';
import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';
import 'package:barber_booking_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetServices {
  GetServices(this._repository);
  final BookingRepository _repository;

  Future<Result<List<BarberService>>> call() => _repository.getServices();
}
