namespace PosterApp.Core.Interfaces;

public interface IAuthService
{
    Task<AuthResponseDto> RegisterAsync(RegisterRequestDto request);
    Task<AuthResponseDto> LoginAsync(LoginRequestDto request);
    string GenerateJwtToken(User user);
    string HashPassword(string password);
    bool VerifyPassword(string password, string hash);
}

public interface IOrderService
{
    Task<OrderDto> CreateOrderAsync(Guid userId, CreateOrderDto request);
    Task<OrderDto?> GetOrderByIdAsync(Guid orderId);
    Task<IEnumerable<OrderDto>> GetUserOrdersAsync(Guid userId);
    Task<IEnumerable<OrderDto>> GetAllOrdersAsync();
    Task<OrderDto> UpdateOrderStatusAsync(Guid orderId, UpdateOrderStatusDto request);
    Task<decimal> CalculateOrderTotalAsync(List<OrderItemDto> items, DeliveryType deliveryType);
}

public interface IProductService
{
    Task<IEnumerable<ProductDto>> GetAllProductsAsync();
    Task<ProductDto?> GetProductByIdAsync(Guid id);
    Task<ProductDto> CreateProductAsync(CreateProductDto request);
    Task<ProductDto> UpdateProductAsync(Guid id, CreateProductDto request);
    Task DeleteProductAsync(Guid id);
}

public interface ICustomPosterService
{
    Task<CustomPosterDto> CreateCustomPosterAsync(Guid userId, CreateCustomPosterDto request);
    Task<CustomPosterDto?> GetCustomPosterByIdAsync(Guid id);
    Task<IEnumerable<CustomPosterDto>> GetUserCustomPostersAsync(Guid userId);
    decimal CalculatePosterPrice(string size, string frameType, int quantity = 1);
}
