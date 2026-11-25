import 'package:barber_booking_app/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:barber_booking_app/features/booking/presentation/cubit/booking_state.dart';
import 'package:barber_booking_app/features/booking/presentation/widgets/booking_form.dart';
import 'package:barber_booking_app/features/booking/presentation/widgets/booking_intro_card.dart';
import 'package:barber_booking_app/features/booking/presentation/widgets/service_card.dart';
import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingOverview extends StatelessWidget {
  const BookingOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state.servicesPhase == ServicesPhase.loading ||
            state.servicesPhase == ServicesPhase.initial) {
          return Center(
            child: Semantics(
              label: l10n.loadingServices,
              child: const CircularProgressIndicator(),
            ),
          );
        }
        if (state.servicesPhase == ServicesPhase.failure) {
          return Center(
            child: FilledButton.icon(
              onPressed: context.read<BookingCubit>().loadServices,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l10n.retry),
            ),
          );
        }
        if (state.servicesPhase == ServicesPhase.empty) {
          return Center(child: Text(l10n.emptyServices));
        }

        return SafeArea(
          top: false,
          child: RefreshIndicator(
            onRefresh: context.read<BookingCubit>().loadServices,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              children: [
                const BookingIntroCard(),
                const SizedBox(height: 28),
                Text(
                  l10n.servicesTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.servicesSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 14),
                for (final service in state.services) ...[
                  ServiceCard(
                    service: service,
                    selected: state.selectedService?.id == service.id,
                    onTap: () =>
                        context.read<BookingCubit>().selectService(service),
                  ),
                  const SizedBox(height: 10),
                ],
                const SizedBox(height: 14),
                BookingForm(
                  key: ValueKey(state.bookingConfirmationVersion),
                  isSubmitting: state.isSubmitting,
                  onSubmit: (name, phone, startsAt) => context
                      .read<BookingCubit>()
                      .submit(name: name, phone: phone, startsAt: startsAt),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
