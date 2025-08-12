using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using PosterApp.Core.Interfaces;
using PosterApp.Core.Services;
using PosterApp.Infrastructure.Data;
using PosterApp.Infrastructure.Repositories;
using PosterApp.Infrastructure.Mappings;

namespace PosterApp.Infrastructure.Extensions;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
    {
        // Database
        services.AddDbContext<AppDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        // AutoMapper
        services.AddAutoMapper(typeof(MappingProfile));

        // Repositories
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<IProductRepository, ProductRepository>();
        services.AddScoped<ICustomPosterRepository, CustomPosterRepository>();
        services.AddScoped<IOrderRepository, OrderRepository>();

        // Services
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<IProductService, ProductService>();
        services.AddScoped<ICustomPosterService, CustomPosterService>();
        services.AddScoped<IOrderService, OrderService>();

        return services;
    }
}
