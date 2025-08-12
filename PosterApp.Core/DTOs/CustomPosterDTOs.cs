public record CreateCustomPosterDto(
    string ImageUrl,
    string Size,
    string FrameType,
    int Quantity = 1
);

public record CustomPosterDto(
    Guid Id,
    string ImageUrl,
    string Size,
    string FrameType,
    decimal FramePrice,
    decimal BasePrice,
    decimal TotalPrice
);
