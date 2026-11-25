import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_state.dart';
import 'package:barber_booking_app/features/booking/presentation/widgets/appointment_card.dart';
import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentHistoryView extends StatelessWidget {
  const AppointmentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state.historyPhase == HistoryPhase.loading ||
            state.historyPhase == HistoryPhase.initial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.historyPhase == HistoryPhase.failure) {
          return Center(
            child: FilledButton.icon(
              onPressed: context.read<BookingCubit>().loadAppointments,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l10n.retry),
            ),
          );
        }

        return SafeArea(
          top: false,
          child: RefreshIndicator(
            onRefresh: context.read<BookingCubit>().loadAppointments,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.appointmentHistoryTitle,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.appointmentHistorySubtitle,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.historyPhase == HistoryPhase.empty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyHistory(
                      title: l10n.emptyAppointments,
                      description: l10n.emptyAppointmentsDescription,
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                    sliver: SliverList.separated(
                      itemCount: state.appointments.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final appointment = state.appointments[index];
                        return AppointmentCard(
                          appointment: appointment,
                          service: _serviceFor(appointment, state.services),
                          isCancelling:
                              state.cancellingAppointmentId == appointment.id,
                          onCancel: () =>
                              _confirmCancellation(context, appointment),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  BarberService? _serviceFor(
    Appointment appointment,
    List<BarberService> services,
  ) {
    for (final service in services) {
      if (service.id == appointment.serviceId) return service;
    }
    return null;
  }

  Future<void> _confirmCancellation(
    BuildContext context,
    Appointment appointment,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.event_busy_rounded),
        title: Text(l10n.cancelAppointmentTitle),
        content: Text(l10n.cancelAppointmentMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.keepAppointment),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.confirmCancellation),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<BookingCubit>().cancel(appointment.id);
    }
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: colors.secondaryContainer,
            foregroundColor: colors.onSecondaryContainer,
            child: const Icon(Icons.event_note_rounded, size: 36),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
