
using PosterApp.Core.Entities;
using PosterApp.Shared.Enums;

namespace PosterApp.Infrastructure.Data;

public static class DataSeeder
{
    public static void SeedData(AppDbContext context)
    {
        // Seed products if none exist
        if (!context.Products.Any())
        {
            var products = new List<Product>
            {
                new()
                {
                    Name = "Abstract Geometric Art",
                    Description = "Modern abstract geometric artwork perfect for contemporary spaces.",
                    ImageUrl = "https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400",
                    Category = "Abstract",
                    Price = 24.99m,
                    Size = "30cm x 40cm",
                    IsActive = true
                },
                new()
                {
                    Name = "Nature Landscape",
                    Description = "Beautiful nature landscape poster featuring mountain scenery.",
                    ImageUrl = "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400",
                    Category = "Nature",
                    Price = 29.99m,
                    Size = "40cm x 50cm",
                    IsActive = true
                },
                new()
                {
                    Name = "Minimalist Typography",
                    Description = "Clean minimalist typography design for modern homes.",
                    ImageUrl = "https://images.unsplash.com/photo-1555421689-491a97ff2040?w=400",
                    Category = "Typography",
                    Price = 19.99m,
                    Size = "30cm x 40cm",
                    IsActive = true
                },
                new()
                {
                    Name = "Vintage Travel Poster",
                    Description = "Retro-style travel poster with vintage appeal.",
                    ImageUrl = "https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400",
                    Category = "Vintage",
                    Price = 34.99m,
                    Size = "50cm x 70cm",
                    IsActive = true
                },
                new()
                {
                    Name = "Urban Architecture",
                    Description = "Black and white urban architecture photography.",
                    ImageUrl = "https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=400",
                    Category = "Architecture",
                    Price = 39.99m,
                    Size = "50cm x 70cm",
                    IsActive = true
                }
            };

            context.Products.AddRange(products);
            context.SaveChanges();
        }

        // Seed a test admin user
        if (!context.Users.Any(u => u.Email == "admin@posterapp.com"))
        {
            var adminUser = new User
            {
                FullName = "Admin User",
                Email = "admin@posterapp.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("Admin123!")
            };

            context.Users.Add(adminUser);
            context.SaveChanges();
        }
    }
}
