import 'package:barber_booking_app/core/network/api_client.dart';
import 'package:barber_booking_app/features/booking/data/models/appointment_model.dart';
import 'package:barber_booking_app/features/booking/data/models/service_model.dart';
import 'package:injectable/injectable.dart';

abstract interface class BookingRemoteDataSource {
  Future<List<ServiceModel>> getServices();
  Future<List<AppointmentModel>> getAppointments();
  Future<AppointmentModel> createAppointment(Map<String, dynamic> payload);
  Future<void> cancelAppointment(String appointmentId);
}

@LazySingleton(as: BookingRemoteDataSource)
class DioBookingRemoteDataSource implements BookingRemoteDataSource {
  DioBookingRemoteDataSource(this._client);
  final ApiClient _client;

  @override
  Future<List<ServiceModel>> getServices() async {
    final response = await _client.dio.get<Map<String, dynamic>>('services');
    final items = response.data?['items'] as List<dynamic>? ?? const [];
    return items
        .map((item) => ServiceModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    final response = await _client.dio.get<Map<String, dynamic>>(
      'appointments',
    );
    final items = response.data?['items'] as List<dynamic>? ?? const [];
    return items
        .map((item) => AppointmentModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<AppointmentModel> createAppointment(
    Map<String, dynamic> payload,
  ) async {
    final response = await _client.dio.post<Map<String, dynamic>>(
      'appointments',
      data: payload,
    );
    return AppointmentModel.fromJson(response.data!);
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    await _client.dio.delete<void>('appointments/$appointmentId');
  }
}
