using System;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using BarberBooking.Backend.Application.Appointments;

namespace BarberBooking.Backend.Api.Controllers
{
    [RoutePrefix("api/v1/services")]
    public sealed class ServicesController : ApiController
    {
        private readonly IAppointmentApplicationService _applicationService;

        public ServicesController(IAppointmentApplicationService applicationService)
        {
            _applicationService = applicationService ?? throw new ArgumentNullException(nameof(applicationService));
        }

        [HttpGet, Route("")]
        public async Task<IHttpActionResult> Get(CancellationToken cancellationToken)
        {
            return Ok(await _applicationService.ListServicesAsync(cancellationToken));
        }
    }
}
