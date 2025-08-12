public class CustomPoster
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid UserId { get; set; }
    public string ImageUrl { get; set; } = string.Empty;
    public string Size { get; set; } = string.Empty;
    public string FrameType { get; set; } = "None";
    public decimal FramePrice { get; set; }
    public decimal BasePrice { get; set; }
    public decimal TotalPrice { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    
    // Navigation properties
    public virtual User User { get; set; } = null!;
}
