using System.Data.Entity;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;
using BarberBooking.Backend.App_Start;
using BarberBooking.Backend.Infrastructure.Persistence;

namespace BarberBooking.Backend
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            Database.SetInitializer(new BarberBookingDatabaseInitializer());
            GlobalConfiguration.Configure(configuration =>
            {
                DependencyConfig.Register(configuration);
                WebApiConfig.Register(configuration);
            });
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }
    }
}
