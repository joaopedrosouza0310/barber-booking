namespace BarberBooking.Backend.Api.Models
{
    public sealed class ApiError
    {
        public ApiError(string code, string message)
        {
            Code = code;
            Message = message;
        }

        public string Code { get; }
        public string Message { get; }
    }
}
