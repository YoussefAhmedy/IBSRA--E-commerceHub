public record CreateOrderDto(
    List<OrderItemDto> Items,
    ShippingInfoDto ShippingInfo,
    DeliveryType DeliveryType
);

public record OrderItemDto(
    Guid? ProductId,
    Guid? CustomPosterId,
    int Quantity,
    ItemType ItemType
);

public record ShippingInfoDto(
    string FullName,
    string Address,
    string City,
    string ZipCode,
    string Phone
);

public record OrderDto(
    Guid Id,
    string OrderNumber,
    OrderStatus Status,
    decimal TotalAmount,
    decimal ShippingCost,
    string ShippingAddress,
    DateTime? EstimatedDeliveryStart,
    DateTime? EstimatedDeliveryEnd,
    DateTime CreatedAt,
    List<OrderItemDetailDto> Items
);

public record OrderItemDetailDto(
    Guid Id,
    string ItemName,
    int Quantity,
    decimal UnitPrice,
    decimal TotalPrice,
    ItemType ItemType,
    string? ImageUrl
);

public record UpdateOrderStatusDto(
    OrderStatus Status,
    DateTime? EstimatedDeliveryStart = null,
    DateTime? EstimatedDeliveryEnd = null
);
