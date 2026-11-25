import 'package:barber_booking_app/app/app.dart';
import 'package:barber_booking_app/core/di/injection.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const BarberBookingApp());
}
