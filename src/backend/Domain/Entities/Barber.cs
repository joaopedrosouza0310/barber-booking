using System;

namespace BarberBooking.Backend.Domain.Entities
{
    public sealed class Barber
    {
        private Barber() { }

        public Barber(Guid id, string displayName)
        {
            if (id == Guid.Empty) throw new ArgumentException("A barber identifier is required.", nameof(id));
            if (string.IsNullOrWhiteSpace(displayName)) throw new ArgumentException("A display name is required.", nameof(displayName));

            Id = id;
            DisplayName = displayName.Trim();
            IsActive = true;
        }

        public Guid Id { get; private set; }
        public string DisplayName { get; private set; }
        public bool IsActive { get; private set; }
    }
}
