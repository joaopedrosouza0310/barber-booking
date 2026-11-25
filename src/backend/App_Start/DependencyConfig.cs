using System.Web.Http;
using BarberBooking.Backend.Infrastructure.Composition;

namespace BarberBooking.Backend.App_Start
{
    public static class DependencyConfig
    {
        public static void Register(HttpConfiguration configuration)
        {
            configuration.DependencyResolver = new ApiDependencyResolver();
        }
    }
}
