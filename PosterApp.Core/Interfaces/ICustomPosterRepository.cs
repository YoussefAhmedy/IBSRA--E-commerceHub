public interface ICustomPosterRepository : IGenericRepository<CustomPoster>
{
    Task<IEnumerable<CustomPoster>> GetUserCustomPostersAsync(Guid userId);
}
