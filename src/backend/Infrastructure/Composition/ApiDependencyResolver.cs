using System;
using System.Collections.Generic;
using System.Web.Http.Dependencies;
using BarberBooking.Backend.Api.Controllers;
using BarberBooking.Backend.Application.Appointments;
using BarberBooking.Backend.Infrastructure.Persistence;
using BarberBooking.Backend.Infrastructure.Repositories;

namespace BarberBooking.Backend.Infrastructure.Composition
{
    public sealed class ApiDependencyResolver : IDependencyResolver
    {
        public IDependencyScope BeginScope() => new ApiRequestScope();
        public object GetService(Type serviceType) => null;
        public IEnumerable<object> GetServices(Type serviceType) => Array.Empty<object>();
        public void Dispose() { }

        private sealed class ApiRequestScope : IDependencyScope
        {
            private readonly BarberBookingDbContext _dbContext = new BarberBookingDbContext();

            public object GetService(Type serviceType)
            {
                var applicationService = CreateApplicationService();
                if (serviceType == typeof(AppointmentsController)) return new AppointmentsController(applicationService);
                if (serviceType == typeof(ServicesController)) return new ServicesController(applicationService);
                if (serviceType == typeof(IAppointmentApplicationService)) return applicationService;
                return null;
            }

            public IEnumerable<object> GetServices(Type serviceType) => Array.Empty<object>();

            public void Dispose() => _dbContext.Dispose();

            private IAppointmentApplicationService CreateApplicationService()
            {
                return new AppointmentApplicationService(
                    new AppointmentRepository(_dbContext),
                    new BarberCatalogRepository(_dbContext));
            }
        }
    }
}
