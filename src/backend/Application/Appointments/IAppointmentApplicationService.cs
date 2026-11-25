using System;
using System.Threading;
using System.Threading.Tasks;
using BarberBooking.Backend.Application.Common;

namespace BarberBooking.Backend.Application.Appointments
{
    public interface IAppointmentApplicationService
    {
        Task<ServiceListResponse> ListServicesAsync(CancellationToken cancellationToken);
        Task<AppointmentListResponse> ListAppointmentsAsync(CancellationToken cancellationToken);
        Task<ApplicationResult<AppointmentResponse>> CreateAsync(CreateAppointmentRequest request, CancellationToken cancellationToken);
        Task<ApplicationResult<bool>> CancelAsync(Guid appointmentId, CancellationToken cancellationToken);
    }
}
