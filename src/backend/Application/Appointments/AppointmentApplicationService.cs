using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using BarberBooking.Backend.Application.Common;
using BarberBooking.Backend.Domain.Entities;
using BarberBooking.Backend.Domain.Repositories;

namespace BarberBooking.Backend.Application.Appointments
{
    public sealed class AppointmentApplicationService : IAppointmentApplicationService
    {
        private readonly IAppointmentRepository _appointmentRepository;
        private readonly IBarberCatalogRepository _catalogRepository;

        public AppointmentApplicationService(IAppointmentRepository appointmentRepository, IBarberCatalogRepository catalogRepository)
        {
            _appointmentRepository = appointmentRepository ?? throw new ArgumentNullException(nameof(appointmentRepository));
            _catalogRepository = catalogRepository ?? throw new ArgumentNullException(nameof(catalogRepository));
        }

        public async Task<ServiceListResponse> ListServicesAsync(CancellationToken cancellationToken)
        {
            var services = await _catalogRepository.ListServicesAsync(cancellationToken);
            return new ServiceListResponse
            {
                Items = services.Select(service => new ServiceResponse
                {
                    Id = service.Id,
                    Name = service.Name,
                    DurationMinutes = service.DurationMinutes,
                    Price = service.Price
                }).ToArray()
            };
        }

        public async Task<AppointmentListResponse> ListAppointmentsAsync(int page, int pageSize, CancellationToken cancellationToken)
        {
            var appointments = await _appointmentRepository.ListAsync(cancellationToken);
            page = Math.Max(1, page);
            pageSize = Math.Max(1, Math.Min(100, pageSize));
            var totalItems = appointments.Count;
            return new AppointmentListResponse
            {
                Items = appointments.Skip((page - 1) * pageSize).Take(pageSize).Select(MapAppointment).ToArray(),
                Page = page,
                PageSize = pageSize,
                TotalItems = totalItems,
                TotalPages = (int)Math.Ceiling(totalItems / (double)pageSize)
            };
        }

        public async Task<ApplicationResult<AppointmentResponse>> CreateAsync(CreateAppointmentRequest request, CancellationToken cancellationToken)
        {
            if (request == null) return ApplicationResult<AppointmentResponse>.Failure("invalid_request");

            var service = await _catalogRepository.FindServiceAsync(request.ServiceId, cancellationToken);
            if (service == null) return ApplicationResult<AppointmentResponse>.Failure("service_not_found");
            if (!await _catalogRepository.IsActiveBarberAsync(request.BarberId, cancellationToken))
                return ApplicationResult<AppointmentResponse>.Failure("barber_not_found");

            var startsAtUtc = request.StartsAt.UtcDateTime;
            if (startsAtUtc <= DateTime.UtcNow) return ApplicationResult<AppointmentResponse>.Failure("start_time_in_past");

            var appointment = new Appointment(
                Guid.NewGuid(),
                request.BarberId,
                request.ServiceId,
                request.CustomerName,
                request.CustomerPhone,
                startsAtUtc,
                startsAtUtc.AddMinutes(service.DurationMinutes));

            if (!await _appointmentRepository.TryAddWithoutConflictAsync(appointment, cancellationToken))
                return ApplicationResult<AppointmentResponse>.Failure("appointment_conflict");

            return ApplicationResult<AppointmentResponse>.Success(MapAppointment(appointment));
        }

        public async Task<ApplicationResult<bool>> CancelAsync(Guid appointmentId, CancellationToken cancellationToken)
        {
            if (appointmentId == Guid.Empty) return ApplicationResult<bool>.Failure("invalid_appointment_id");

            var appointment = await _appointmentRepository.FindAsync(appointmentId, cancellationToken);
            if (appointment == null) return ApplicationResult<bool>.Failure("appointment_not_found");
            if (!appointment.Cancel()) return ApplicationResult<bool>.Failure("appointment_not_cancellable");

            await _appointmentRepository.SaveChangesAsync(cancellationToken);
            return ApplicationResult<bool>.Success(true);
        }

        private static AppointmentResponse MapAppointment(Appointment appointment)
        {
            return new AppointmentResponse
            {
                Id = appointment.Id,
                BarberId = appointment.BarberId,
                ServiceId = appointment.ServiceId,
                StartsAt = new DateTimeOffset(appointment.StartsAtUtc),
                EndsAt = new DateTimeOffset(appointment.EndsAtUtc),
                Status = appointment.Status.ToString()
            };
        }
    }
}
