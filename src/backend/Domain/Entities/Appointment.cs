using System;
using BarberBooking.Backend.Domain.Enums;

namespace BarberBooking.Backend.Domain.Entities
{
    public sealed class Appointment
    {
        private Appointment() { }

        public Appointment(Guid id, Guid barberId, Guid serviceId, string customerName, string customerPhone, DateTime startsAtUtc, DateTime endsAtUtc)
        {
            if (id == Guid.Empty) throw new ArgumentException("An appointment identifier is required.", nameof(id));
            if (barberId == Guid.Empty) throw new ArgumentException("A barber is required.", nameof(barberId));
            if (serviceId == Guid.Empty) throw new ArgumentException("A service is required.", nameof(serviceId));
            if (string.IsNullOrWhiteSpace(customerName)) throw new ArgumentException("A customer name is required.", nameof(customerName));
            if (string.IsNullOrWhiteSpace(customerPhone)) throw new ArgumentException("A customer phone is required.", nameof(customerPhone));
            if (startsAtUtc.Kind != DateTimeKind.Utc) throw new ArgumentException("Start time must use UTC.", nameof(startsAtUtc));
            if (endsAtUtc <= startsAtUtc) throw new ArgumentException("End time must be after start time.", nameof(endsAtUtc));

            Id = id;
            BarberId = barberId;
            ServiceId = serviceId;
            CustomerName = customerName.Trim();
            CustomerPhone = customerPhone.Trim();
            StartsAtUtc = startsAtUtc;
            EndsAtUtc = endsAtUtc;
            Status = AppointmentStatus.Scheduled;
            CreatedAtUtc = DateTime.UtcNow;
        }

        public Guid Id { get; private set; }
        public Guid BarberId { get; private set; }
        public Guid ServiceId { get; private set; }
        public string CustomerName { get; private set; }
        public string CustomerPhone { get; private set; }
        public DateTime StartsAtUtc { get; private set; }
        public DateTime EndsAtUtc { get; private set; }
        public AppointmentStatus Status { get; private set; }
        public DateTime CreatedAtUtc { get; private set; }

        public bool Cancel()
        {
            if (Status != AppointmentStatus.Scheduled) return false;

            Status = AppointmentStatus.Cancelled;
            return true;
        }
    }
}
