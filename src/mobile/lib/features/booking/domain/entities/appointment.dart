enum AppointmentStatus { scheduled, completed, cancelled, noShow }

final class Appointment {
  const Appointment({
    required this.id,
    required this.serviceId,
    required this.startsAt,
    required this.endsAt,
    required this.status,
  });

  final String id;
  final String serviceId;
  final DateTime startsAt;
  final DateTime endsAt;
  final AppointmentStatus status;
}
