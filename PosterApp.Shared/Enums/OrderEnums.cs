namespace PosterApp.Shared.Enums;

public enum OrderStatus
{
    Pending = 1,
    Processing = 2,
    Shipped = 3,
    Delivered = 4,
    Cancelled = 5
}

public enum DeliveryType
{
    Standard = 1,
    Express = 2
}

public enum ItemType
{
    Product = 1,
    Custom = 2
}
