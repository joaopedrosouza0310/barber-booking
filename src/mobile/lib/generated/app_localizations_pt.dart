// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Agenda da Barbearia';

  @override
  String get navBook => 'Agendar';

  @override
  String get navAppointments => 'Agendamentos';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get bookingTitle => 'Agende seu próximo corte';

  @override
  String get bookingSubtitle => 'Um visual renovado está a poucos toques.';

  @override
  String get bookingEyebrow => 'SUA PRÓXIMA VISITA';

  @override
  String get servicesTitle => 'Serviços';

  @override
  String get servicesSubtitle => 'Escolha a experiência ideal para o seu dia.';

  @override
  String get scheduleTitle => 'Agendamento';

  @override
  String get customerNameLabel => 'Seu nome';

  @override
  String get customerPhoneLabel => 'Telefone';

  @override
  String get dateLabel => 'Data';

  @override
  String get timeLabel => 'Horário';

  @override
  String get chooseDate => 'Escolher data';

  @override
  String get chooseTime => 'Escolher horário';

  @override
  String get bookNow => 'Agendar agora';

  @override
  String get bookingConfirmed => 'Seu agendamento foi confirmado.';

  @override
  String get appointmentHistoryTitle => 'Seus agendamentos';

  @override
  String get appointmentHistorySubtitle =>
      'Acompanhe as próximas visitas e seu histórico.';

  @override
  String get emptyAppointments => 'Nenhum agendamento ainda';

  @override
  String get emptyAppointmentsDescription =>
      'Seus agendamentos confirmados aparecerão aqui.';

  @override
  String get cancelAppointment => 'Cancelar agendamento';

  @override
  String get cancelAppointmentTitle => 'Cancelar este agendamento?';

  @override
  String get cancelAppointmentMessage =>
      'Este horário ficará disponível para outro cliente.';

  @override
  String get keepAppointment => 'Manter agendamento';

  @override
  String get confirmCancellation => 'Sim, cancelar';

  @override
  String get appointmentCancelled => 'O agendamento foi cancelado.';

  @override
  String get cancellationError =>
      'Não foi possível cancelar este agendamento. Tente novamente.';

  @override
  String get statusScheduled => 'Agendado';

  @override
  String get statusCompleted => 'Concluído';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get statusNoShow => 'Não compareceu';

  @override
  String appointmentTimeRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String get validationRequired => 'Preencha todos os campos antes de agendar.';

  @override
  String get loadingServices => 'Carregando serviços';

  @override
  String get emptyServices => 'Nenhum serviço está disponível agora.';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get genericError => 'Algo deu errado. Tente novamente.';

  @override
  String get conflictError =>
      'Esse horário acabou de ser ocupado. Escolha outro.';

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String price(String amount) {
    return 'R\$ $amount';
  }

  @override
  String get appearance => 'Aparência';

  @override
  String get settingsTitle => 'Deixe do seu jeito';

  @override
  String get settingsSubtitle =>
      'Escolha como o Agenda da Barbearia aparece e fala com você.';

  @override
  String get themeDescription => 'Selecione a aparência que você prefere.';

  @override
  String get languageDescription =>
      'Escolha o idioma usado em todo o aplicativo.';

  @override
  String get systemTheme => 'Tema do sistema';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get darkTheme => 'Tema escuro';

  @override
  String get language => 'Idioma';

  @override
  String get english => 'English';

  @override
  String get portuguese => 'Português';
}
