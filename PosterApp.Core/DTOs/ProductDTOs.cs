public record ProductDto(
    Guid Id,
    string Name,
    string Description,
    string ImageUrl,
    string Category,
    decimal Price,
    string Size,
    bool IsActive
);

public record CreateProductDto(
    string Name,
    string Description,
    string ImageUrl,
    string Category,
    decimal Price,
    string Size
);
