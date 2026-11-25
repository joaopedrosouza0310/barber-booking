using System.Data.Entity;
using BarberBooking.Backend.Domain.Entities;

namespace BarberBooking.Backend.Infrastructure.Persistence
{
    public sealed class BarberBookingDbContext : DbContext
    {
        public BarberBookingDbContext() : base("name=BarberBookingConnection") { }

        public DbSet<Appointment> Appointments { get; set; }
        public DbSet<Barber> Barbers { get; set; }
        public DbSet<BarberService> Services { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Barber>().ToTable("Barbers").HasKey(item => item.Id);
            modelBuilder.Entity<Barber>().Property(item => item.DisplayName).IsRequired().HasMaxLength(100);

            modelBuilder.Entity<BarberService>().ToTable("Services").HasKey(item => item.Id);
            modelBuilder.Entity<BarberService>().Property(item => item.Name).IsRequired().HasMaxLength(100);
            modelBuilder.Entity<BarberService>().Property(item => item.Price).HasPrecision(10, 2);

            modelBuilder.Entity<Appointment>().ToTable("Appointments").HasKey(item => item.Id);
            modelBuilder.Entity<Appointment>().Property(item => item.CustomerName).IsRequired().HasMaxLength(100);
            modelBuilder.Entity<Appointment>().Property(item => item.CustomerPhone).IsRequired().HasMaxLength(30);
            modelBuilder.Entity<Appointment>().HasIndex(item => new { item.BarberId, item.StartsAtUtc, item.EndsAtUtc });

            base.OnModelCreating(modelBuilder);
        }
    }
}
