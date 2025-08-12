using AutoMapper;
using PosterApp.Core.DTOs;
using PosterApp.Core.Entities;
using PosterApp.Core.Interfaces;
using PosterApp.Shared.Constants;

namespace PosterApp.Core.Services;

public class CustomPosterService : ICustomPosterService
{
    private readonly ICustomPosterRepository _customPosterRepository;
    private readonly IMapper _mapper;

    public CustomPosterService(ICustomPosterRepository customPosterRepository, IMapper mapper)
    {
        _customPosterRepository = customPosterRepository;
        _mapper = mapper;
    }

    public async Task<CustomPosterDto> CreateCustomPosterAsync(Guid userId, CreateCustomPosterDto request)
    {
        var basePrice = GetBasePriceBySize(request.Size);
        var framePrice = GetFramePrice(request.FrameType);
        var totalPrice = CalculatePosterPrice(request.Size, request.FrameType, request.Quantity);

        var customPoster = _mapper.Map<CustomPoster>(request);
        customPoster.UserId = userId;
        customPoster.BasePrice = basePrice;
        customPoster.FramePrice = framePrice;
        customPoster.TotalPrice = totalPrice;

        await _customPosterRepository.AddAsync(customPoster);
        return _mapper.Map<CustomPosterDto>(customPoster);
    }

    public async Task<CustomPosterDto?> GetCustomPosterByIdAsync(Guid id)
    {
        var customPoster = await _customPosterRepository.GetByIdAsync(id);
        return customPoster != null ? _mapper.Map<CustomPosterDto>(customPoster) : null;
    }

    public async Task<IEnumerable<CustomPosterDto>> GetUserCustomPostersAsync(Guid userId)
    {
        var customPosters = await _customPosterRepository.GetUserCustomPostersAsync(userId);
        return _mapper.Map<IEnumerable<CustomPosterDto>>(customPosters);
    }

    public decimal CalculatePosterPrice(string size, string frameType, int quantity = 1)
    {
        var basePrice = GetBasePriceBySize(size);
        var framePrice = GetFramePrice(frameType);
        return (basePrice + framePrice) * quantity;
    }

    private static decimal GetBasePriceBySize(string size) => size switch
    {
        "8x10" => 25m,
        "11x14" => 35m,
        "16x20" => 45m,
        "18x24" => 55m,
        _ => 25m
    };

    private static decimal GetFramePrice(string frameType) => frameType switch
    {
        "None" => 0m,
        "Black" => 25m,
        "Red" => 25m,
        "Natural" => 30m,
        "Dark" => 35m,
        _ => 0m
    };
}
