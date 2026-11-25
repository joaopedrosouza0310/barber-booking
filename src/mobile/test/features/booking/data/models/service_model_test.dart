import 'package:barber_booking_app/features/booking/data/models/service_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps an API service payload into the domain entity', () {
    final model = ServiceModel.fromJson({
      'id': 'service-id',
      'name': 'Classic haircut',
      'durationMinutes': 45,
      'price': 35.0,
    });

    final service = model.toDomain();

    expect(service.id, 'service-id');
    expect(service.name, 'Classic haircut');
    expect(service.durationMinutes, 45);
    expect(service.price, 35.0);
  });
}
