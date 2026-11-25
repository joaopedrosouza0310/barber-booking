using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using BarberBooking.Backend.Api.Models;
using BarberBooking.Backend.Application.Appointments;

namespace BarberBooking.Backend.Api.Controllers
{
    [RoutePrefix("api/v1/appointments")]
    public sealed class AppointmentsController : ApiController
    {
        private readonly IAppointmentApplicationService _applicationService;

        public AppointmentsController(IAppointmentApplicationService applicationService)
        {
            _applicationService = applicationService ?? throw new ArgumentNullException(nameof(applicationService));
        }

        [HttpGet, Route("")]
        public async Task<IHttpActionResult> Get(CancellationToken cancellationToken)
        {
            return Ok(await _applicationService.ListAppointmentsAsync(cancellationToken));
        }

        [HttpPost, Route("")]
        public async Task<IHttpActionResult> Post(CreateAppointmentRequest request, CancellationToken cancellationToken)
        {
            if (!ModelState.IsValid) return Content(HttpStatusCode.BadRequest, new ApiError("validation_failed", "The request is invalid."));

            var result = await _applicationService.CreateAsync(request, cancellationToken);
            if (result.Succeeded)
            {
                return Created(new Uri(Request.RequestUri, "./" + result.Value.Id), result.Value);
            }

            if (result.ErrorCode == "appointment_conflict")
                return Content(HttpStatusCode.Conflict, new ApiError(result.ErrorCode, "The selected time is no longer available."));
            if (result.ErrorCode == "service_not_found" || result.ErrorCode == "barber_not_found")
                return Content(HttpStatusCode.NotFound, new ApiError(result.ErrorCode, "The requested resource was not found."));

            return Content(HttpStatusCode.BadRequest, new ApiError(result.ErrorCode, "The appointment could not be created."));
        }

        [HttpDelete, Route("{appointmentId:guid}")]
        public async Task<IHttpActionResult> Delete(Guid appointmentId, CancellationToken cancellationToken)
        {
            var result = await _applicationService.CancelAsync(appointmentId, cancellationToken);
            if (result.Succeeded) return StatusCode(HttpStatusCode.NoContent);
            if (result.ErrorCode == "appointment_not_found")
                return Content(HttpStatusCode.NotFound, new ApiError(result.ErrorCode, "The appointment was not found."));
            if (result.ErrorCode == "appointment_not_cancellable")
                return Content(HttpStatusCode.Conflict, new ApiError(result.ErrorCode, "The appointment can no longer be cancelled."));

            return Content(HttpStatusCode.BadRequest, new ApiError(result.ErrorCode, "The appointment could not be cancelled."));
        }
    }
}
