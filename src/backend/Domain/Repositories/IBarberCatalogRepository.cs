using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using BarberBooking.Backend.Domain.Entities;

namespace BarberBooking.Backend.Domain.Repositories
{
    public interface IBarberCatalogRepository
    {
        Task<IReadOnlyCollection<BarberService>> ListServicesAsync(CancellationToken cancellationToken);
        Task<BarberService> FindServiceAsync(Guid id, CancellationToken cancellationToken);
        Task<bool> IsActiveBarberAsync(Guid id, CancellationToken cancellationToken);
    }
}
