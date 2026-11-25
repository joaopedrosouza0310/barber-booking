using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using BarberBooking.Backend.Domain.Entities;
using BarberBooking.Backend.Domain.Enums;
using BarberBooking.Backend.Domain.Repositories;
using BarberBooking.Backend.Infrastructure.Persistence;

namespace BarberBooking.Backend.Infrastructure.Repositories
{
    public sealed class AppointmentRepository : IAppointmentRepository
    {
        private readonly BarberBookingDbContext _dbContext;

        public AppointmentRepository(BarberBookingDbContext dbContext)
        {
            _dbContext = dbContext ?? throw new ArgumentNullException(nameof(dbContext));
        }

        public async Task<IReadOnlyCollection<Appointment>> ListAsync(CancellationToken cancellationToken)
        {
            return await _dbContext.Appointments
                .AsNoTracking()
                .OrderByDescending(appointment => appointment.StartsAtUtc)
                .ToArrayAsync(cancellationToken);
        }

        public Task<Appointment> FindAsync(Guid appointmentId, CancellationToken cancellationToken)
        {
            return _dbContext.Appointments.SingleOrDefaultAsync(
                appointment => appointment.Id == appointmentId,
                cancellationToken);
        }

        public async Task<bool> TryAddWithoutConflictAsync(Appointment appointment, CancellationToken cancellationToken)
        {
            using (var transaction = _dbContext.Database.BeginTransaction(IsolationLevel.Serializable))
            {
                var hasConflict = await _dbContext.Appointments.AnyAsync(
                    current => current.BarberId == appointment.BarberId
                        && current.Status == AppointmentStatus.Scheduled
                        && current.StartsAtUtc < appointment.EndsAtUtc
                        && current.EndsAtUtc > appointment.StartsAtUtc,
                    cancellationToken);

                if (hasConflict)
                {
                    transaction.Rollback();
                    return false;
                }

                _dbContext.Appointments.Add(appointment);
                await _dbContext.SaveChangesAsync(cancellationToken);
                transaction.Commit();
                return true;
            }
        }

        public Task SaveChangesAsync(CancellationToken cancellationToken)
        {
            return _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
