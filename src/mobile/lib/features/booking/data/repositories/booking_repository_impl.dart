import 'package:barber_booking_app/core/error/app_failure.dart';
import 'package:barber_booking_app/core/result/result.dart';
import 'package:barber_booking_app/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';
import 'package:barber_booking_app/features/booking/domain/repositories/booking_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BookingRepository)
class BookingRepositoryImpl implements BookingRepository {
  BookingRepositoryImpl(this._remoteDataSource);
  final BookingRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<BarberService>>> getServices() async {
    try {
      final models = await _remoteDataSource.getServices();
      return Success(
        models.map((model) => model.toDomain()).toList(growable: false),
      );
    } on DioException catch (error) {
      return FailureResult(_mapDio(error));
    } catch (_) {
      return const FailureResult(AppFailure(FailureKind.unexpected));
    }
  }

  @override
  Future<Result<List<Appointment>>> getAppointments() async {
    try {
      final models = await _remoteDataSource.getAppointments();
      return Success(
        models.map((model) => model.toDomain()).toList(growable: false),
      );
    } on DioException catch (error) {
      return FailureResult(_mapDio(error));
    } catch (_) {
      return const FailureResult(AppFailure(FailureKind.unexpected));
    }
  }

  @override
  Future<Result<Appointment>> createAppointment({
    required String barberId,
    required String serviceId,
    required String customerName,
    required String customerPhone,
    required DateTime startsAt,
  }) async {
    try {
      final model = await _remoteDataSource.createAppointment({
        'barberId': barberId,
        'serviceId': serviceId,
        'customerName': customerName,
        'customerPhone': customerPhone,
        'startsAt': startsAt.toUtc().toIso8601String(),
      });
      return Success(model.toDomain());
    } on DioException catch (error) {
      return FailureResult(_mapDio(error));
    } catch (_) {
      return const FailureResult(AppFailure(FailureKind.unexpected));
    }
  }

  @override
  Future<Result<bool>> cancelAppointment(String appointmentId) async {
    try {
      await _remoteDataSource.cancelAppointment(appointmentId);
      return const Success(true);
    } on DioException catch (error) {
      return FailureResult(_mapDio(error));
    } catch (_) {
      return const FailureResult(AppFailure(FailureKind.unexpected));
    }
  }

  AppFailure _mapDio(DioException error) {
    final status = error.response?.statusCode;
    final body = error.response?.data;
    final code = body is Map<String, dynamic> ? body['code'] as String? : null;
    if (status == 409) return AppFailure(FailureKind.conflict, code: code);
    if (status == 400) return AppFailure(FailureKind.validation, code: code);
    if (status == 404) return AppFailure(FailureKind.notFound, code: code);
    return AppFailure(FailureKind.network, code: code);
  }
}
