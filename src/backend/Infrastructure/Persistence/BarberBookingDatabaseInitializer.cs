using System;
using System.Data.Entity;
using BarberBooking.Backend.Domain.Entities;

namespace BarberBooking.Backend.Infrastructure.Persistence
{
    public sealed class BarberBookingDatabaseInitializer : CreateDatabaseIfNotExists<BarberBookingDbContext>
    {
        public static readonly Guid DefaultBarberId = Guid.Parse("c14c50cd-dcb6-418a-b4a1-6029e57efe82");

        protected override void Seed(BarberBookingDbContext context)
        {
            context.Barbers.Add(new Barber(DefaultBarberId, "Alex Morgan"));
            context.Services.Add(new BarberService(Guid.Parse("5550e346-b003-45b4-824c-cbb629895ce1"), "Classic haircut", 45, 35m));
            context.Services.Add(new BarberService(Guid.Parse("e4246767-80de-4d24-879f-b75f50928b54"), "Beard trim", 30, 25m));
            context.Services.Add(new BarberService(Guid.Parse("ea7d4776-2bf6-4e1c-93fd-579b5bc033a4"), "Haircut and beard", 75, 55m));
            context.SaveChanges();
        }
    }
}
