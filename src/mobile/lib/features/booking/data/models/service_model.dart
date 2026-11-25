import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';

final class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.name,
    required this.durationMinutes,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json['id'] as String,
    name: json['name'] as String,
    durationMinutes: json['durationMinutes'] as int,
    price: (json['price'] as num).toDouble(),
  );

  final String id;
  final String name;
  final int durationMinutes;
  final double price;

  BarberService toDomain() => BarberService(
    id: id,
    name: name,
    durationMinutes: durationMinutes,
    price: price,
  );
}
