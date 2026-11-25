// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:barber_booking_app/app/locale_cubit.dart' as _i788;
import 'package:barber_booking_app/core/di/register_module.dart' as _i165;
import 'package:barber_booking_app/core/network/api_client.dart' as _i1069;
import 'package:barber_booking_app/core/theme/theme_cubit.dart' as _i504;
import 'package:barber_booking_app/features/booking/data/datasources/booking_remote_data_source.dart'
    as _i417;
import 'package:barber_booking_app/features/booking/data/repositories/booking_repository_impl.dart'
    as _i201;
import 'package:barber_booking_app/features/booking/domain/repositories/booking_repository.dart'
    as _i21;
import 'package:barber_booking_app/features/booking/domain/usecases/cancel_appointment.dart'
    as _i290;
import 'package:barber_booking_app/features/booking/domain/usecases/create_appointment.dart'
    as _i857;
import 'package:barber_booking_app/features/booking/domain/usecases/get_appointments.dart'
    as _i280;
import 'package:barber_booking_app/features/booking/domain/usecases/get_services.dart'
    as _i347;
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_cubit.dart'
    as _i911;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i1069.ApiClient>(() => _i1069.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i788.LocaleCubit>(
      () => _i788.LocaleCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i504.ThemeCubit>(
      () => _i504.ThemeCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i417.BookingRemoteDataSource>(
      () => _i417.DioBookingRemoteDataSource(gh<_i1069.ApiClient>()),
    );
    gh.lazySingleton<_i21.BookingRepository>(
      () => _i201.BookingRepositoryImpl(gh<_i417.BookingRemoteDataSource>()),
    );
    gh.factory<_i290.CancelAppointment>(
      () => _i290.CancelAppointment(gh<_i21.BookingRepository>()),
    );
    gh.factory<_i857.CreateAppointment>(
      () => _i857.CreateAppointment(gh<_i21.BookingRepository>()),
    );
    gh.factory<_i280.GetAppointments>(
      () => _i280.GetAppointments(gh<_i21.BookingRepository>()),
    );
    gh.factory<_i347.GetServices>(
      () => _i347.GetServices(gh<_i21.BookingRepository>()),
    );
    gh.factory<_i911.BookingCubit>(
      () => _i911.BookingCubit(
        gh<_i347.GetServices>(),
        gh<_i857.CreateAppointment>(),
        gh<_i280.GetAppointments>(),
        gh<_i290.CancelAppointment>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i165.RegisterModule {}
