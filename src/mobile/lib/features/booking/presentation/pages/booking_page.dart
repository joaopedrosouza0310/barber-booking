import 'package:barber_booking_app/core/error/app_failure.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_state.dart';
import 'package:barber_booking_app/features/booking/presentation/pages/appointment_history_view.dart';
import 'package:barber_booking_app/features/booking/presentation/pages/booking_overview.dart';
import 'package:barber_booking_app/features/booking/presentation/pages/settings_view.dart';
import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _pageController = PageController();
  int _selectedIndex = 0;
  int _handledBookingVersion = 0;
  int _handledCancellationVersion = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<BookingCubit, BookingState>(
      listenWhen: (previous, current) =>
          previous.bookingConfirmationVersion !=
              current.bookingConfirmationVersion ||
          previous.cancellationVersion != current.cancellationVersion ||
          previous.failure != current.failure ||
          previous.historyFailure != current.historyFailure,
      listener: (context, state) {
        if (state.bookingConfirmationVersion > _handledBookingVersion) {
          _handledBookingVersion = state.bookingConfirmationVersion;
          _showMessage(context, l10n.bookingConfirmed);
          _goToPage(1);
          return;
        }
        if (state.cancellationVersion > _handledCancellationVersion) {
          _handledCancellationVersion = state.cancellationVersion;
          _showMessage(context, l10n.appointmentCancelled);
          return;
        }
        final failure = state.historyFailure ?? state.failure;
        if (failure != null) {
          _showMessage(context, _failureMessage(l10n, failure));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          titleSpacing: 20,
          title: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.content_cut_rounded, size: 22),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _selectedIndex = index),
          children: const [
            BookingOverview(),
            AppointmentHistoryView(),
            SettingsView(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _goToPage,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.calendar_month_outlined),
              selectedIcon: const Icon(Icons.calendar_month_rounded),
              label: l10n.navBook,
            ),
            NavigationDestination(
              icon: const Icon(Icons.history_rounded),
              selectedIcon: const Icon(Icons.event_note_rounded),
              label: l10n.navAppointments,
            ),
            NavigationDestination(
              icon: const Icon(Icons.tune_rounded),
              selectedIcon: const Icon(Icons.tune_rounded),
              label: l10n.navSettings,
            ),
          ],
        ),
      ),
    );
  }

  void _goToPage(int index) {
    if (!mounted) return;
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String _failureMessage(AppLocalizations l10n, AppFailure failure) {
    if (failure.kind == FailureKind.conflict) return l10n.conflictError;
    if (failure.kind == FailureKind.validation) {
      return l10n.validationRequired;
    }
    if (failure.code == 'appointment_not_cancellable') {
      return l10n.cancellationError;
    }
    return l10n.genericError;
  }
}
