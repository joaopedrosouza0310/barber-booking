import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';

final class AppointmentModel {
  const AppointmentModel({
    required this.id,
    required this.serviceId,
    required this.startsAt,
    required this.endsAt,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'] as String,
        serviceId: json['serviceId'] as String,
        startsAt: DateTime.parse(json['startsAt'] as String),
        endsAt: DateTime.parse(json['endsAt'] as String),
        status: _parseStatus(json['status'] as String),
      );

  final String id;
  final String serviceId;
  final DateTime startsAt;
  final DateTime endsAt;
  final AppointmentStatus status;

  Appointment toDomain() => Appointment(
    id: id,
    serviceId: serviceId,
    startsAt: startsAt,
    endsAt: endsAt,
    status: status,
  );

  static AppointmentStatus _parseStatus(String value) {
    switch (value.toLowerCase()) {
      case 'scheduled':
        return AppointmentStatus.scheduled;
      case 'completed':
        return AppointmentStatus.completed;
      case 'cancelled':
        return AppointmentStatus.cancelled;
      case 'noshow':
        return AppointmentStatus.noShow;
      default:
        throw FormatException('Unknown appointment status: $value');
    }
  }
}
