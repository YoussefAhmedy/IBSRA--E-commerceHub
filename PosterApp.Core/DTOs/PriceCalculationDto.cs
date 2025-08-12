namespace PosterApp.Core.DTOs;

public record PriceCalculationDto(
    string Size,
    string FrameType,
    int Quantity = 1
);
