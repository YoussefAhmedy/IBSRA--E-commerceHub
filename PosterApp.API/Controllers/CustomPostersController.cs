using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PosterApp.Core.DTOs;
using PosterApp.Core.Interfaces;

namespace PosterApp.API.Controllers;

[Authorize]
public class CustomPostersController : BaseController
{
    private readonly ICustomPosterService _customPosterService;

    public CustomPostersController(ICustomPosterService customPosterService)
    {
        _customPosterService = customPosterService;
    }

    [HttpPost]
    public async Task<IActionResult> CreateCustomPoster([FromBody] CreateCustomPosterDto request)
    {
        try
        {
            var userId = GetCurrentUserId();
            var customPoster = await _customPosterService.CreateCustomPosterAsync(userId, request);
            return Ok(customPoster);
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }

    [HttpGet]
    public async Task<IActionResult> GetUserCustomPosters()
    {
        try
        {
            var userId = GetCurrentUserId();
            var customPosters = await _customPosterService.GetUserCustomPostersAsync(userId);
            return Ok(customPosters);
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetCustomPoster(Guid id)
    {
        try
        {
            var customPoster = await _customPosterService.GetCustomPosterByIdAsync(id);
            return customPoster != null ? Ok(customPoster) : NotFound();
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }

    [HttpPost("calculate-price")]
    public IActionResult CalculatePrice([FromBody] PriceCalculationDto request)
    {
        try
        {
            var price = _customPosterService.CalculatePosterPrice(request.Size, request.FrameType, request.Quantity);
            return Ok(new { Price = price });
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }
}
