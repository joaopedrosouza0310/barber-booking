using System;

namespace BarberBooking.Backend.Domain.Entities
{
    public sealed class BarberService
    {
        private BarberService() { }

        public BarberService(Guid id, string name, int durationMinutes, decimal price)
        {
            if (id == Guid.Empty) throw new ArgumentException("A service identifier is required.", nameof(id));
            if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("A service name is required.", nameof(name));
            if (durationMinutes <= 0) throw new ArgumentOutOfRangeException(nameof(durationMinutes));
            if (price < 0) throw new ArgumentOutOfRangeException(nameof(price));

            Id = id;
            Name = name.Trim();
            DurationMinutes = durationMinutes;
            Price = price;
            IsActive = true;
        }

        public Guid Id { get; private set; }
        public string Name { get; private set; }
        public int DurationMinutes { get; private set; }
        public decimal Price { get; private set; }
        public bool IsActive { get; private set; }
    }
}
