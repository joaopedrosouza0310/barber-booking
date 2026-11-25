import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class BookingIntroCard extends StatelessWidget {
  const BookingIntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            bottom: -24,
            child: Icon(
              Icons.content_cut_rounded,
              size: 150,
              color: colors.onPrimary.withValues(alpha: 0.10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.bookingEyebrow,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.82),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.bookingTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.bookingSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.86),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
