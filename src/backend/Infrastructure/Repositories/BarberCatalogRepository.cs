using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using BarberBooking.Backend.Domain.Entities;
using BarberBooking.Backend.Domain.Repositories;
using BarberBooking.Backend.Infrastructure.Persistence;

namespace BarberBooking.Backend.Infrastructure.Repositories
{
    public sealed class BarberCatalogRepository : IBarberCatalogRepository
    {
        private readonly BarberBookingDbContext _dbContext;

        public BarberCatalogRepository(BarberBookingDbContext dbContext)
        {
            _dbContext = dbContext ?? throw new ArgumentNullException(nameof(dbContext));
        }

        public async Task<IReadOnlyCollection<BarberService>> ListServicesAsync(CancellationToken cancellationToken)
        {
            return await _dbContext.Services.AsNoTracking().Where(item => item.IsActive).OrderBy(item => item.Name).ToListAsync(cancellationToken);
        }

        public Task<BarberService> FindServiceAsync(Guid id, CancellationToken cancellationToken)
        {
            return _dbContext.Services.AsNoTracking().SingleOrDefaultAsync(item => item.Id == id && item.IsActive, cancellationToken);
        }

        public Task<bool> IsActiveBarberAsync(Guid id, CancellationToken cancellationToken)
        {
            return _dbContext.Barbers.AsNoTracking().AnyAsync(item => item.Id == id && item.IsActive, cancellationToken);
        }
    }
}
