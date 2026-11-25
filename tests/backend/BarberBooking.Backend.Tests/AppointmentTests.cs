using System;
using BarberBooking.Backend.Domain.Entities;
using BarberBooking.Backend.Domain.Enums;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace BarberBooking.Backend.Tests
{
    [TestClass]
    public sealed class AppointmentTests
    {
        [TestMethod]
        public void Constructor_rejects_non_utc_start_time()
        {
            Assert.ThrowsException<ArgumentException>(() => new Appointment(
                Guid.NewGuid(), Guid.NewGuid(), Guid.NewGuid(), "Alex", "+15555550123",
                DateTime.Now.AddDays(1), DateTime.Now.AddDays(1).AddMinutes(30)));
        }

        [TestMethod]
        public void Cancel_transitions_a_scheduled_appointment_only_once()
        {
            var start = DateTime.UtcNow.AddDays(1);
            var appointment = new Appointment(Guid.NewGuid(), Guid.NewGuid(), Guid.NewGuid(), "Alex", "+15555550123", start, start.AddMinutes(30));

            Assert.IsTrue(appointment.Cancel());
            Assert.AreEqual(AppointmentStatus.Cancelled, appointment.Status);
            Assert.IsFalse(appointment.Cancel());
        }
    }
}
