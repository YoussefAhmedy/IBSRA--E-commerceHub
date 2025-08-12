using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PosterApp.Core.DTOs;
using PosterApp.Core.Interfaces;

namespace PosterApp.API.Controllers;

[Authorize]
public class OrdersController : BaseController
{
    private readonly IOrderService _orderService;

    public OrdersController(IOrderService orderService)
    {
        _orderService = orderService;
    }

    [HttpPost]
    public async Task<IActionResult> CreateOrder([FromBody] CreateOrderDto request)
    {
        try
        {
            var userId = GetCurrentUserId();
            var order = await _orderService.CreateOrderAsync(userId, request);
            return Ok(order);
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }

    [HttpGet]
    public async Task<IActionResult> GetUserOrders()
    {
        try
        {
            var userId = GetCurrentUserId();
            var orders = await _orderService.GetUserOrdersAsync(userId);
            return Ok(orders);
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetOrder(Guid id)
    {
        try
        {
            var order = await _orderService.GetOrderByIdAsync(id);
            return order != null ? Ok(order) : NotFound();
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }

    // Admin endpoints
    [HttpGet("admin/all")]
    [Authorize] // Add admin role check
    public async Task<IActionResult> GetAllOrders()
    {
        try
        {
            var orders = await _orderService.GetAllOrdersAsync();
            return Ok(orders);
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }

    [HttpPut("{id}/status")]
    [Authorize] // Admin only
    public async Task<IActionResult> UpdateOrderStatus(Guid id, [FromBody] UpdateOrderStatusDto request)
    {
        try
        {
            var order = await _orderService.UpdateOrderStatusAsync(id, request);
            return Ok(order);
        }
        catch (Exception ex)
        {
            return HandleException(ex);
        }
    }
}
