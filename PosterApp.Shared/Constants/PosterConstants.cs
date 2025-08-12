namespace PosterApp.Shared.Constants;

public static class PosterConstants
{
    public static class Sizes
    {
        public const string Small = "8x10";
        public const string Medium = "11x14";
        public const string Large = "16x20";
        public const string ExtraLarge = "18x24";
    }

    public static class FrameTypes
    {
        public const string None = "None";
        public const string Black = "Black";
        public const string Red = "Red";
        public const string Natural = "Natural";
        public const string Dark = "Dark";
    }

    public static class DeliveryDays
    {
        public const int StandardMin = 5;
        public const int StandardMax = 7;
        public const int ExpressMin = 2;
        public const int ExpressMax = 3;
    }
}
