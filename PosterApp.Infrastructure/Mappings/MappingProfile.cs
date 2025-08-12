using AutoMapper;
using PosterApp.Core.Entities;
using PosterApp.Core.DTOs;

namespace PosterApp.Infrastructure.Mappings;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        // User mappings
        CreateMap<User, AuthResponseDto>();
        CreateMap<RegisterRequestDto, User>();

        // Product mappings
        CreateMap<Product, ProductDto>();
        CreateMap<CreateProductDto, Product>();

        // Custom Poster mappings
        CreateMap<CustomPoster, CustomPosterDto>();
        CreateMap<CreateCustomPosterDto, CustomPoster>();

        // Order mappings
        CreateMap<Order, OrderDto>()
            .ForMember(dest => dest.Items, opt => opt.MapFrom(src => src.OrderItems));
        
        CreateMap<OrderItem, OrderItemDetailDto>()
            .ForMember(dest => dest.ItemName, opt => opt.MapFrom(src => 
                src.Product != null ? src.Product.Name : "Custom Poster"))
            .ForMember(dest => dest.ImageUrl, opt => opt.MapFrom(src => 
                src.Product != null ? src.Product.ImageUrl : src.CustomPoster!.ImageUrl));
    }
}
