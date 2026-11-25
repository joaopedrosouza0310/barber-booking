import 'package:barber_booking_app/features/booking/domain/entities/appointment.dart';
import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';
import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.service,
    required this.isCancelling,
    required this.onCancel,
  });

  final Appointment appointment;
  final BarberService? service;
  final bool isCancelling;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final startsAt = appointment.startsAt.toLocal();
    final endsAt = appointment.endsAt.toLocal();
    final canCancel =
        appointment.status == AppointmentStatus.scheduled &&
        startsAt.isAfter(DateTime.now());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat.MMM(locale).format(startsAt).toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        DateFormat.d(locale).format(startsAt),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service?.name ?? l10n.servicesTitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 17,
                            color: colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            l10n.appointmentTimeRange(
                              DateFormat.jm(locale).format(startsAt),
                              DateFormat.jm(locale).format(endsAt),
                            ),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _StatusChip(status: appointment.status),
              ],
            ),
            if (canCancel) ...[
              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: isCancelling ? null : onCancel,
                  icon: isCancelling
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.close_rounded),
                  label: Text(l10n.cancelAppointment),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final (label, color, foreground) = switch (status) {
      AppointmentStatus.scheduled => (
        l10n.statusScheduled,
        colors.secondaryContainer,
        colors.onSecondaryContainer,
      ),
      AppointmentStatus.completed => (
        l10n.statusCompleted,
        colors.primaryContainer,
        colors.onPrimaryContainer,
      ),
      AppointmentStatus.cancelled => (
        l10n.statusCancelled,
        colors.errorContainer,
        colors.onErrorContainer,
      ),
      AppointmentStatus.noShow => (
        l10n.statusNoShow,
        colors.surfaceContainerHighest,
        colors.onSurfaceVariant,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
