using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BarberBooking.Backend.Application.Appointments
{
    public sealed class CreateAppointmentRequest
    {
        [Required]
        public Guid BarberId { get; set; }

        [Required]
        public Guid ServiceId { get; set; }

        [Required, StringLength(100, MinimumLength = 2)]
        public string CustomerName { get; set; }

        [Required, StringLength(30, MinimumLength = 8)]
        public string CustomerPhone { get; set; }

        [Required]
        public DateTimeOffset StartsAt { get; set; }
    }

    public sealed class AppointmentResponse
    {
        public Guid Id { get; set; }
        public Guid BarberId { get; set; }
        public Guid ServiceId { get; set; }
        public DateTimeOffset StartsAt { get; set; }
        public DateTimeOffset EndsAt { get; set; }
        public string Status { get; set; }
    }

    public sealed class AppointmentListResponse
    {
        public IReadOnlyCollection<AppointmentResponse> Items { get; set; }
        public int Page { get; set; }
        public int PageSize { get; set; }
        public int TotalItems { get; set; }
        public int TotalPages { get; set; }
    }

    public sealed class ServiceResponse
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public int DurationMinutes { get; set; }
        public decimal Price { get; set; }
    }

    public sealed class ServiceListResponse
    {
        public IReadOnlyCollection<ServiceResponse> Items { get; set; }
    }
}
