using Microsoft.EntityFrameworkCore;
using PosterApp.Core.Entities;
using PosterApp.Shared.Enums;

namespace PosterApp.Infrastructure.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    public DbSet<User> Users { get; set; }
    public DbSet<Product> Products { get; set; }
    public DbSet<CustomPoster> CustomPosters { get; set; }
    public DbSet<Order> Orders { get; set; }
    public DbSet<OrderItem> OrderItems { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // User configuration
        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.Email).IsUnique();
            entity.Property(e => e.Email).HasMaxLength(255);
            entity.Property(e => e.FullName).HasMaxLength(100);
        });

        // Product configuration
        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Price).HasPrecision(10, 2);
        });

        // Custom Poster configuration
        modelBuilder.Entity<CustomPoster>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.BasePrice).HasPrecision(10, 2);
            entity.Property(e => e.FramePrice).HasPrecision(10, 2);
            entity.Property(e => e.TotalPrice).HasPrecision(10, 2);
            
            entity.HasOne(e => e.User)
                  .WithMany(e => e.CustomPosters)
                  .HasForeignKey(e => e.UserId);
        });

        // Order configuration
        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.OrderNumber).IsUnique();
            entity.Property(e => e.TotalAmount).HasPrecision(10, 2);
            entity.Property(e => e.ShippingCost).HasPrecision(10, 2);
            
            entity.Property(e => e.Status)
                  .HasConversion<string>();
            
            entity.Property(e => e.DeliveryType)
                  .HasConversion<string>();

            entity.HasOne(e => e.User)
                  .WithMany(e => e.Orders)
                  .HasForeignKey(e => e.UserId);
        });

        // Order Item configuration
        modelBuilder.Entity<OrderItem>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.UnitPrice).HasPrecision(10, 2);
            entity.Property(e => e.TotalPrice).HasPrecision(10, 2);
            
            entity.Property(e => e.ItemType)
                  .HasConversion<string>();

            entity.HasOne(e => e.Order)
                  .WithMany(e => e.OrderItems)
                  .HasForeignKey(e => e.OrderId);

            entity.HasOne(e => e.Product)
                  .WithMany()
                  .HasForeignKey(e => e.ProductId);

            entity.HasOne(e => e.CustomPoster)
                  .WithMany()
                  .HasForeignKey(e => e.CustomPosterId);
        });
    }
}
