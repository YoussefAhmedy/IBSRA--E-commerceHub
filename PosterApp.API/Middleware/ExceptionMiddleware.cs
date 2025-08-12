using System.Net;
using System.Text.Json;
using PosterApp.Core.Exceptions;

namespace PosterApp.API.Middleware;

public class ExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionMiddleware> _logger;

    public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An unhandled exception occurred");
            await HandleExceptionAsync(context, ex);
        }
    }

    private static async Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        context.Response.ContentType = "application/json";
        
        var response = exception switch
        {
            ValidationException => new { message = exception.Message, statusCode = (int)HttpStatusCode.BadRequest },
            BusinessRuleException => new { message = exception.Message, statusCode = (int)HttpStatusCode.BadRequest },
            KeyNotFoundException => new { message = exception.Message, statusCode = (int)HttpStatusCode.NotFound },
            UnauthorizedAccessException => new { message = exception.Message, statusCode = (int)HttpStatusCode.Unauthorized },
            _ => new { message = "An error occurred while processing your request.", statusCode = (int)HttpStatusCode.InternalServerError }
        };

        context.Response.StatusCode = response.statusCode;
        await context.Response.WriteAsync(JsonSerializer.Serialize(response));
    }
}
