using AutoMapper;
using PosterApp.Core.DTOs;
using PosterApp.Core.Entities;
using PosterApp.Core.Interfaces;
using PosterApp.Shared.Enums;

namespace PosterApp.Core.Services;

public class OrderService : IOrderService
{
    private readonly IOrderRepository _orderRepository;
    private readonly IProductRepository _productRepository;
    private readonly ICustomPosterRepository _customPosterRepository;
    private readonly IMapper _mapper;

    public OrderService(
        IOrderRepository orderRepository,
        IProductRepository productRepository,
        ICustomPosterRepository customPosterRepository,
        IMapper mapper)
    {
        _orderRepository = orderRepository;
        _productRepository = productRepository;
        _customPosterRepository = customPosterRepository;
        _mapper = mapper;
    }

    public async Task<OrderDto> CreateOrderAsync(Guid userId, CreateOrderDto request)
    {
        var orderNumber = await _orderRepository.GenerateOrderNumberAsync();
        var orderTotal = await CalculateOrderTotalAsync(request.Items, request.DeliveryType);
        var shippingCost = GetShippingCost(request.DeliveryType);

        var order = new Order
        {
            OrderNumber = orderNumber,
            UserId = userId,
            TotalAmount = orderTotal,
            ShippingCost = shippingCost,
            ShippingAddress = request.ShippingInfo.Address,
            ShippingCity = request.ShippingInfo.City,
            ShippingZipCode = request.ShippingInfo.ZipCode,
            Phone = request.ShippingInfo.Phone,
            DeliveryType = request.DeliveryType,
            EstimatedDeliveryStart = CalculateDeliveryDate(request.DeliveryType),
            EstimatedDeliveryEnd = CalculateDeliveryDate(request.DeliveryType, true)
        };

        // Add order items
        foreach (var itemDto in request.Items)
        {
            var orderItem = new OrderItem
            {
                OrderId = order.Id,
                ProductId = itemDto.ProductId,
                CustomPosterId = itemDto.CustomPosterId,
                Quantity = itemDto.Quantity,
                ItemType = itemDto.ItemType
            };

            if (itemDto.ItemType == ItemType.Product && itemDto.ProductId.HasValue)
            {
                var product = await _productRepository.GetByIdAsync(itemDto.ProductId.Value);
                if (product == null) throw new KeyNotFoundException("Product not found");
                
                orderItem.UnitPrice = product.Price;
                orderItem.TotalPrice = product.Price * itemDto.Quantity;
            }
            else if (itemDto.ItemType == ItemType.Custom && itemDto.CustomPosterId.HasValue)
            {
                var customPoster = await _customPosterRepository.GetByIdAsync(itemDto.CustomPosterId.Value);
                if (customPoster == null) throw new KeyNotFoundException("Custom poster not found");
                
                orderItem.UnitPrice = customPoster.TotalPrice;
                orderItem.TotalPrice = customPoster.TotalPrice * itemDto.Quantity;
            }

            order.OrderItems.Add(orderItem);
        }

        await _orderRepository.AddAsync(order);
        
        var createdOrder = await _orderRepository.GetOrderWithDetailsAsync(order.Id);
        return _mapper.Map<OrderDto>(createdOrder);
    }

    public async Task<OrderDto?> GetOrderByIdAsync(Guid orderId)
    {
        var order = await _orderRepository.GetOrderWithDetailsAsync(orderId);
        return order != null ? _mapper.Map<OrderDto>(order) : null;
    }

    public async Task<IEnumerable<OrderDto>> GetUserOrdersAsync(Guid userId)
    {
        var orders = await _orderRepository.GetUserOrdersAsync(userId);
        return _mapper.Map<IEnumerable<OrderDto>>(orders);
    }

    public async Task<IEnumerable<OrderDto>> GetAllOrdersAsync()
    {
        var orders = await _orderRepository.GetAllAsync();
        return _mapper.Map<IEnumerable<OrderDto>>(orders);
    }

    public async Task<OrderDto> UpdateOrderStatusAsync(Guid orderId, UpdateOrderStatusDto request)
    {
        var order = await _orderRepository.GetOrderWithDetailsAsync(orderId);
        if (order == null)
            throw new KeyNotFoundException("Order not found");

        order.Status = request.Status;
        order.UpdatedAt = DateTime.UtcNow;
        
        if (request.EstimatedDeliveryStart.HasValue)
            order.EstimatedDeliveryStart = request.EstimatedDeliveryStart;
        
        if (request.EstimatedDeliveryEnd.HasValue)
            order.EstimatedDeliveryEnd = request.EstimatedDeliveryEnd;

        await _orderRepository.UpdateAsync(order);
        return _mapper.Map<OrderDto>(order);
    }

    public async Task<decimal> CalculateOrderTotalAsync(List<OrderItemDto> items, DeliveryType deliveryType)
    {
        decimal total = 0;

        foreach (var item in items)
        {
            if (item.ItemType == ItemType.Product && item.ProductId.HasValue)
            {
                var product = await _productRepository.GetByIdAsync(item.ProductId.Value);
                if (product != null)
                    total += product.Price * item.Quantity;
            }
            else if (item.ItemType == ItemType.Custom && item.CustomPosterId.HasValue)
            {
                var customPoster = await _customPosterRepository.GetByIdAsync(item.CustomPosterId.Value);
                if (customPoster != null)
                    total += customPoster.TotalPrice * item.Quantity;
            }
        }

        total += GetShippingCost(deliveryType);
        return total;
    }

    private static decimal GetShippingCost(DeliveryType deliveryType) => deliveryType switch
    {
        DeliveryType.Standard => 5m,
        DeliveryType.Express => 12m,
        _ => 5m
    };

    private static DateTime CalculateDeliveryDate(DeliveryType deliveryType, bool isEndDate = false)
    {
        var baseDate = DateTime.Today.AddDays(1); // Start from tomorrow
        return deliveryType switch
        {
            DeliveryType.Express => isEndDate ? baseDate.AddDays(3) : baseDate.AddDays(2),
            DeliveryType.Standard => isEndDate ? baseDate.AddDays(7) : baseDate.AddDays(5),
            _ => isEndDate ? baseDate.AddDays(7) : baseDate.AddDays(5)
        };
    }
}
