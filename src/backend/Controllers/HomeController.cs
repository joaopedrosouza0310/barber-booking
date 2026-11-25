using System.Web.Mvc;

namespace BarberBooking.Backend.Controllers
{
    public sealed class HomeController : Controller
    {
        public ActionResult Index() => View();
    }
}
