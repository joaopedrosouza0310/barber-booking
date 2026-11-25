import 'package:barber_booking_app/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final Future<void> Function(String name, String phone, DateTime startsAt)
  onSubmit;

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _date;
  TimeOfDay? _time;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colors.secondaryContainer,
                  foregroundColor: colors.onSecondaryContainer,
                  child: const Icon(Icons.event_available_rounded),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.scheduleTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              enabled: !widget.isSubmitting,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              decoration: InputDecoration(
                labelText: l10n.customerNameLabel,
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              enabled: !widget.isSubmitting,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.telephoneNumber],
              decoration: InputDecoration(
                labelText: l10n.customerPhoneLabel,
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _PickerButton(
                    icon: Icons.calendar_today_outlined,
                    label: _date == null
                        ? l10n.chooseDate
                        : DateFormat.yMMMd(
                            Localizations.localeOf(context).toString(),
                          ).format(_date!),
                    onPressed: widget.isSubmitting ? null : _chooseDate,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _PickerButton(
                    icon: Icons.schedule_rounded,
                    label: _time?.format(context) ?? l10n.chooseTime,
                    onPressed: widget.isSubmitting ? null : _chooseTime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: widget.isSubmitting ? null : _submit,
              icon: widget.isSubmitting
                  ? const SizedBox.square(
                      dimension: 19,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.arrow_forward_rounded),
              label: Text(l10n.bookNow),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _chooseDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final value = await showDatePicker(
      context: context,
      firstDate: today,
      lastDate: today.add(const Duration(days: 90)),
      initialDate: _date ?? today,
    );
    if (value != null && mounted) setState(() => _date = value);
  }

  Future<void> _chooseTime() async {
    final value = await showTimePicker(
      context: context,
      initialTime: _time ?? const TimeOfDay(hour: 10, minute: 0),
    );
    if (value != null && mounted) setState(() => _time = value);
  }

  Future<void> _submit() async {
    final date = _date;
    final time = _time;
    if (date == null || time == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.validationRequired),
        ),
      );
      return;
    }
    FocusScope.of(context).unfocus();
    await widget.onSubmit(
      _nameController.text,
      _phoneController.text,
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }
}

class _PickerButton extends StatelessWidget {
  const _PickerButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 19),
      label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
