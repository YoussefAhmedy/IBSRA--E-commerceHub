using System.ComponentModel.DataAnnotations;

namespace PosterApp.Core.DTOs;

public record RegisterRequestDto(
    [Required, StringLength(100, MinimumLength = 2)] string FullName,
    [Required, EmailAddress] string Email,
    [Required, StringLength(100, MinimumLength = 6)] string Password
);

public record LoginRequestDto(
    [Required, EmailAddress] string Email,
    [Required] string Password
);

public record CreateProductDto(
    [Required, StringLength(200, MinimumLength = 1)] string Name,
    [StringLength(500)] string Description,
    [Required, Url] string ImageUrl,
    [Required, StringLength(100)] string Category,
    [Required, Range(0.01, 10000)] decimal Price,
    [Required, StringLength(50)] string Size
);

public record CreateCustomPosterDto(
    [Required, Url] string ImageUrl,
    [Required] string Size,
    [Required] string FrameType,
    [Range(1, 100)] int Quantity = 1
);

public record CreateOrderDto(
    [Required] List<OrderItemDto> Items,
    [Required] ShippingInfoDto ShippingInfo,
    [Required] DeliveryType DeliveryType
);

public record ShippingInfoDto(
    [Required, StringLength(100)] string FullName,
    [Required, StringLength(500)] string Address,
    [Required, StringLength(100)] string City,
    [Required, StringLength(20)] string ZipCode,
    [Required, Phone] string Phone
);
