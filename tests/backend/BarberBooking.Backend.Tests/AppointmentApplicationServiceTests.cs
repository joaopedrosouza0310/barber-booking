using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using BarberBooking.Backend.Application.Appointments;
using BarberBooking.Backend.Domain.Entities;
using BarberBooking.Backend.Domain.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace BarberBooking.Backend.Tests
{
    [TestClass]
    public sealed class AppointmentApplicationServiceTests
    {
        [TestMethod]
        public async Task ListAppointments_returns_requested_page_and_metadata()
        {
            var repository = new AppointmentRepositoryFake(Enumerable.Range(0, 5).Select(CreateAppointment).ToArray());
            var service = new AppointmentApplicationService(repository, new CatalogRepositoryFake());

            var result = await service.ListAppointmentsAsync(2, 2, CancellationToken.None);

            Assert.AreEqual(2, result.Items.Count);
            Assert.AreEqual(5, result.TotalItems);
            Assert.AreEqual(3, result.TotalPages);
            Assert.AreEqual(2, result.Page);
        }

        [TestMethod]
        public async Task Create_returns_conflict_when_repository_rejects_overlapping_slot()
        {
            var repository = new AppointmentRepositoryFake(Array.Empty<Appointment>()) { AcceptNewAppointment = false };
            var catalog = new CatalogRepositoryFake();
            var service = new AppointmentApplicationService(repository, catalog);

            var result = await service.CreateAsync(new CreateAppointmentRequest
            {
                BarberId = catalog.BarberId,
                ServiceId = catalog.Service.Id,
                CustomerName = "Alex Morgan",
                CustomerPhone = "+15555550123",
                StartsAt = DateTimeOffset.UtcNow.AddDays(1)
            }, CancellationToken.None);

            Assert.IsFalse(result.Succeeded);
            Assert.AreEqual("appointment_conflict", result.ErrorCode);
        }

        private static Appointment CreateAppointment(int index)
        {
            var start = DateTime.UtcNow.AddDays(index + 1);
            return new Appointment(Guid.NewGuid(), Guid.NewGuid(), Guid.NewGuid(), "Customer", "+15555550123", start, start.AddMinutes(30));
        }

        private sealed class AppointmentRepositoryFake : IAppointmentRepository
        {
            private readonly IReadOnlyCollection<Appointment> _appointments;
            public AppointmentRepositoryFake(IReadOnlyCollection<Appointment> appointments) => _appointments = appointments;
            public bool AcceptNewAppointment { get; set; } = true;
            public Task<IReadOnlyCollection<Appointment>> ListAsync(CancellationToken cancellationToken) => Task.FromResult(_appointments);
            public Task<Appointment> FindAsync(Guid appointmentId, CancellationToken cancellationToken) => Task.FromResult(_appointments.FirstOrDefault(item => item.Id == appointmentId));
            public Task<bool> TryAddWithoutConflictAsync(Appointment appointment, CancellationToken cancellationToken) => Task.FromResult(AcceptNewAppointment);
            public Task SaveChangesAsync(CancellationToken cancellationToken) => Task.CompletedTask;
        }

        private sealed class CatalogRepositoryFake : IBarberCatalogRepository
        {
            public Guid BarberId { get; } = Guid.NewGuid();
            public BarberService Service { get; } = new BarberService(Guid.NewGuid(), "Classic haircut", 45, 35m);
            public Task<IReadOnlyCollection<BarberService>> ListServicesAsync(CancellationToken cancellationToken) => Task.FromResult<IReadOnlyCollection<BarberService>>(new[] { Service });
            public Task<BarberService> FindServiceAsync(Guid id, CancellationToken cancellationToken) => Task.FromResult(id == Service.Id ? Service : null);
            public Task<bool> IsActiveBarberAsync(Guid id, CancellationToken cancellationToken) => Task.FromResult(id == BarberId);
        }
    }
}
