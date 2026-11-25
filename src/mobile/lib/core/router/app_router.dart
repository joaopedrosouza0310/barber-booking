import 'package:barber_booking_app/core/di/injection.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:barber_booking_app/features/booking/presentation/pages/booking_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<BookingCubit>()..load(),
        child: const BookingPage(),
      ),
    ),
  ],
);
