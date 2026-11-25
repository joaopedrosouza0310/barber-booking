namespace BarberBooking.Backend.Application.Common
{
    public sealed class ApplicationResult<T>
    {
        private ApplicationResult(bool succeeded, T value, string errorCode)
        {
            Succeeded = succeeded;
            Value = value;
            ErrorCode = errorCode;
        }

        public bool Succeeded { get; }
        public T Value { get; }
        public string ErrorCode { get; }

        public static ApplicationResult<T> Success(T value) => new ApplicationResult<T>(true, value, null);
        public static ApplicationResult<T> Failure(string errorCode) => new ApplicationResult<T>(false, default(T), errorCode);
    }
}
