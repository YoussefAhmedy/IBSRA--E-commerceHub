using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PosterApp.Infrastructure.Data;

namespace PosterApp.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class HealthController : ControllerBase
{
    private readonly AppDbContext _context;
    private readonly ILogger<HealthController> _logger;

    public HealthController(AppDbContext context, ILogger<HealthController> logger)
    {
        _context = context;
        _logger = logger;
    }

    [HttpGet]
    public async Task<IActionResult> Get()
    {
        try
        {
            // Test database connectivity
            await _context.Database.CanConnectAsync();
            
            var health = new
            {
                Status = "Healthy",
                Timestamp = DateTime.UtcNow,
                Version = "1.0.0",
                Database = "Connected",
                Environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Unknown"
            };

            return Ok(health);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Health check failed");
            
            var health = new
            {
                Status = "Unhealthy",
                Timestamp = DateTime.UtcNow,
                Error = ex.Message,
                Database = "Disconnected"
            };

            return StatusCode(503, health);
        }
    }

    [HttpGet("database")]
    public async Task<IActionResult> DatabaseHealth()
    {
        try
        {
            var canConnect = await _context.Database.CanConnectAsync();
            var userCount = await _context.Users.CountAsync();
            var productCount = await _context.Products.CountAsync();
            var orderCount = await _context.Orders.CountAsync();

            var dbHealth = new
            {
                Status = canConnect ? "Healthy" : "Unhealthy",
                Statistics = new
                {
                    TotalUsers = userCount,
                    TotalProducts = productCount,
                    TotalOrders = orderCount
                },
                Timestamp = DateTime.UtcNow
            };

            return Ok(dbHealth);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Database health check failed");
            return StatusCode(503, new { Status = "Unhealthy", Error = ex.Message });
        }
    }
}
