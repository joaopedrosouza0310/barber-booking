using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using BarberBooking.Backend.Domain.Entities;

namespace BarberBooking.Backend.Domain.Repositories
{
    public interface IAppointmentRepository
    {
        Task<IReadOnlyCollection<Appointment>> ListAsync(CancellationToken cancellationToken);
        Task<Appointment> FindAsync(Guid appointmentId, CancellationToken cancellationToken);
        Task<bool> TryAddWithoutConflictAsync(Appointment appointment, CancellationToken cancellationToken);
        Task SaveChangesAsync(CancellationToken cancellationToken);
    }
}
