namespace PosterApp.Core.DTOs;

public record RegisterRequestDto(
    string FullName,
    string Email,
    string Password
);

public record LoginRequestDto(
    string Email,
    string Password
);

public record AuthResponseDto(
    Guid UserId,
    string FullName,
    string Email,
    string Token
);
