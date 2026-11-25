import 'package:barber_booking_app/features/booking/domain/entities/barber_service.dart';
import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
    required this.selected,
    required this.onTap,
  });

  final BarberService service;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: selected
              ? colors.primaryContainer
              : colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: selected
                      ? colors.primary
                      : colors.secondaryContainer,
                  foregroundColor: selected
                      ? colors.onPrimary
                      : colors.onSecondaryContainer,
                  child: const Icon(Icons.content_cut_rounded),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        localizations.minutes(service.durationMinutes),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      localizations.price(service.price.toStringAsFixed(2)),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: selected ? colors.primary : null,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Icon(
                      selected
                          ? Icons.check_circle_rounded
                          : Icons.circle_outlined,
                      size: 20,
                      color: selected ? colors.primary : colors.outline,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
