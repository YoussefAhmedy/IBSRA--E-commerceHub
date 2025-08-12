# IBSRA-E.commerceHub :
# Poster E-commerce API - Setup & Deployment Guide

## 📋 Prerequisites

- .NET 8 SDK
- SQL Server (LocalDB for development)
- Visual Studio 2022 or VS Code
- Postman/Insomnia (for API testing)

## 🚀 Quick Start

### 1. Clone and Setup Project Structure

Create the following project structure:

```
PosterApp/
├── PosterApp.API/
├── PosterApp.Core/
├── PosterApp.Infrastructure/
├── PosterApp.Shared/
└── PosterApp.sln
```

### 2. Create Solution File

```bash
dotnet new sln -n PosterApp
dotnet new webapi -n PosterApp.API
dotnet new classlib -n PosterApp.Core
dotnet new classlib -n PosterApp.Infrastructure
dotnet new classlib -n PosterApp.Shared

# Add projects to solution
dotnet sln add PosterApp.API/PosterApp.API.csproj
dotnet sln add PosterApp.Core/PosterApp.Core.csproj
dotnet sln add PosterApp.Infrastructure/PosterApp.Infrastructure.csproj
dotnet sln add PosterApp.Shared/PosterApp.Shared.csproj

# Add project references
dotnet add PosterApp.API reference PosterApp.Core PosterApp.Infrastructure
dotnet add PosterApp.Core reference PosterApp.Shared
dotnet add PosterApp.Infrastructure reference PosterApp.Core
```

### 3. Install Required Packages

#### PosterApp.API
```bash
cd PosterApp.API
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet add package AutoMapper.Extensions.Microsoft.DependencyInjection
dotnet add package Swashbuckle.AspNetCore
```

#### PosterApp.Core
```bash
cd ../PosterApp.Core
dotnet add package Microsoft.Extensions.Configuration.Abstractions
dotnet add package Microsoft.IdentityModel.Tokens
dotnet add package System.IdentityModel.Tokens.Jwt
dotnet add package AutoMapper
dotnet add package BCrypt.Net-Next
```

#### PosterApp.Infrastructure
```bash
cd ../PosterApp.Infrastructure
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package AutoMapper
```

### 4. Database Setup

#### Update Connection String
In `PosterApp.API/appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=PosterAppDB;Trusted_Connection=true;MultipleActiveResultSets=true"
  },
  "JWT": {
    "Key": "YourSuperSecretKeyThatIsAtLeast32CharactersLong!",
    "Issuer": "PosterApp",
    "Audience": "PosterAppUsers"
  }
}
```

#### Create Database
```bash
# From PosterApp.API directory
dotnet ef migrations add InitialCreate
dotnet ef database update
```

### 5. Run the Application

```bash
cd PosterApp.API
dotnet run
```

The API will be available at:
- HTTP: `http://localhost:5000`
- HTTPS: `https://localhost:5001`
- Swagger UI: `https://localhost:5001/swagger`

## 🧪 Testing the API

### 1. Using Swagger UI
Navigate to `https://localhost:5001/swagger` to access the interactive API documentation.

### 2. Using Postman/Insomnia
Import the provided API collection JSON file.

### 3. Test Flow
1. **Register a new user**: `POST /api/auth/register`
2. **Login**: `POST /api/auth/login` (copy the JWT token)
3. **Get products**: `GET /api/products`
4. **Create custom poster**: `POST /api/customposters`
5. **Create order**: `POST /api/orders`
6. **Get user orders**: `GET /api/orders`

### 4. Admin Dashboard
Access the admin dashboard at `https://localhost:5001/admin.html` with the seeded admin credentials:
- Email: `admin@posterapp.com`
- Password: `Admin123!`

## 📦 Sample API Requests

### Register User
```bash
curl -X POST "https://localhost:5001/api/auth/register" \
-H "Content-Type: application/json" \
-d '{
  "fullName": "John Doe",
  "email": "john@example.com",
  "password": "Password123!"
}'
```

### Login User
```bash
curl -X POST "https://localhost:5001/api/auth/login" \
-H "Content-Type: application/json" \
-d '{
  "email": "john@example.com",
  "password": "Password123!"
}'
```

### Create Custom Poster
```bash
curl -X POST "https://localhost:5001/api/customposters" \
-H "Authorization: Bearer YOUR_JWT_TOKEN" \
-H "Content-Type: application/json" \
-d '{
  "imageUrl": "https://example.com/image.jpg",
  "size": "16x20",
  "frameType": "Black",
  "quantity": 1
}'
```

### Create Order
```bash
curl -X POST "https://localhost:5001/api/orders" \
-H "Authorization: Bearer YOUR_JWT_TOKEN" \
-H "Content-Type: application/json" \
-d '{
  "items": [
    {
      "productId": "PRODUCT_GUID",
      "customPosterId": null,
      "quantity": 2,
      "itemType": 1
    }
  ],
  "shippingInfo": {
    "fullName": "John Doe",
    "address": "123 Main St",
    "city": "New York",
    "zipCode": "10001",
    "phone": "+1234567890"
  },
  "deliveryType": 1
}'
```

## 🚀 Production Deployment

### 1. Azure App Service Deployment

#### Prepare for deployment:
```bash
# Publish the application
dotnet publish -c Release -o ./publish

# Create Azure resources (using Azure CLI)
az group create --name poster-app-rg --location "East US"
az appservice plan create --name poster-app-plan --resource-group poster-app-rg --sku B1
az webapp create --name poster-app-api --resource-group poster-app-rg --plan poster-app-plan
```

#### Deploy:
```bash
# Deploy using Azure CLI
az webapp deployment source config-zip --resource-group poster-app-rg --name poster-app-api --src publish.zip
```

### 2. Docker Deployment

#### Create Dockerfile:
```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["PosterApp.API/PosterApp.API.csproj", "PosterApp.API/"]
COPY ["PosterApp.Core/PosterApp.Core.csproj", "PosterApp.Core/"]
COPY ["PosterApp.Infrastructure/PosterApp.Infrastructure.csproj", "PosterApp.Infrastructure/"]
COPY ["PosterApp.Shared/PosterApp.Shared.csproj", "PosterApp.Shared/"]
RUN dotnet restore "PosterApp.API/PosterApp.API.csproj"
COPY . .
WORKDIR "/src/PosterApp.API"
RUN dotnet build "PosterApp.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PosterApp.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "PosterApp.API.dll"]
```

#### Build and run:
```bash
docker build -t poster-app-api .
docker run -p 8080:80 poster-app-api
```

### 3. Environment Configuration

#### Production appsettings.json:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=your-sql-server;Database=PosterAppDB;User Id=username;Password=password;TrustServerCertificate=true;"
  },
  "JWT": {
    "Key": "your-production-secret-key-here",
    "Issuer": "PosterApp",
    "Audience": "PosterAppUsers"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  }
}
```

## 🔧 Advanced Configuration

### 1. Enable HTTPS in Production
```csharp
// In Program.cs
if (!app.Environment.IsDevelopment())
{
    app.UseHsts();
    app.UseHttpsRedirection();
}
```

### 2. Add Rate Limiting
```bash
dotnet add package Microsoft.AspNetCore.RateLimiting
```

```csharp
// In Program.cs
builder.Services.AddRateLimiter(options =>
{
    options.AddFixedWindowLimiter("api", configure =>
    {
        configure.PermitLimit = 100;
        configure.Window = TimeSpan.FromMinutes(1);
    });
});

app.UseRateLimiter();
```

### 3. Add Caching
```bash
dotnet add package Microsoft.Extensions.Caching.Memory
```

```csharp
// In Program.cs
builder.Services.AddMemoryCache();

// In ProductService
private readonly IMemoryCache _cache;

public async Task<IEnumerable<ProductDto>> GetAllProductsAsync()
{
    const string cacheKey = "all_products";
    
    if (!_cache.TryGetValue(cacheKey, out IEnumerable<ProductDto> products))
    {
        var productEntities = await _productRepository.GetActiveProductsAsync();
        products = _mapper.Map<IEnumerable<ProductDto>>(productEntities);
        
        _cache.Set(cacheKey, products, TimeSpan.FromMinutes(10));
    }
    
    return products;
}
```

### 4. Add Logging
```bash
dotnet add package Serilog.AspNetCore
dotnet add package Serilog.Sinks.File
```

```csharp
// In Program.cs
using Serilog;

Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .WriteTo.File("logs/poster-app-.txt", rollingInterval: RollingInterval.Day)
    .CreateLogger();

builder.Host.UseSerilog();
```

## 🛡️ Security Considerations

### 1. API Security Headers
```csharp
// In Program.cs
app.Use(async (context, next) =>
{
    context.Response.Headers.Add("X-Content-Type-Options", "nosniff");
    context.Response.Headers.Add("X-Frame-Options", "DENY");
    context.Response.Headers.Add("X-XSS-Protection", "1; mode=block");
    await next();
});
```

### 2. Input Validation
- All DTOs include validation attributes
- Use ModelState validation in controllers
- Sanitize user inputs

### 3. JWT Configuration
- Use strong secret keys (256+ bits)
- Set appropriate expiration times
- Consider refresh tokens for production

## 📊 Monitoring and Health Checks

### Health Check Endpoints
- `/api/health` - Basic health check
- `/api/health/database` - Database connectivity and statistics

### Application Insights (Azure)
```bash
dotnet add package Microsoft.ApplicationInsights.AspNetCore
```

```csharp
// In Program.cs
builder.Services.AddApplicationInsightsTelemetry();
```

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Issues**
   - Verify connection string in appsettings.json
   - Ensure SQL Server/LocalDB is running
   - Check firewall settings
   - Run `dotnet ef database update` to ensure migrations are applied

2. **JWT Authentication Issues**
   - Verify JWT secret key length (minimum 256 bits)
   - Check token expiration
   - Ensure proper Bearer token format: `Authorization: Bearer <token>`

3. **CORS Issues**
   - Update CORS policy for your frontend domain
   - Ensure preflight requests are handled correctly

4. **Entity Framework Issues**
   ```bash
   # Reset database if needed
   dotnet ef database drop
   dotnet ef database update
   ```

5. **Package Restore Issues**
   ```bash
   # Clear NuGet cache
   dotnet nuget locals all --clear
   dotnet restore
   ```

### Debug Mode
```bash
# Run in development with detailed errors
export ASPNETCORE_ENVIRONMENT=Development
dotnet run --verbosity normal
```

## 📈 Performance Optimization

### 1. Database Optimization
```csharp
// Add database indexes for frequently queried fields
protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    // Add indexes for better query performance
    modelBuilder.Entity<Order>()
        .HasIndex(o => o.Status);
    
    modelBuilder.Entity<Product>()
        .HasIndex(p => p.Category);
    
    modelBuilder.Entity<User>()
        .HasIndex(u => u.Email)
        .IsUnique();
}
```

### 2. API Response Caching
```csharp
// Add response caching
builder.Services.AddResponseCaching();

// In controllers
[ResponseCache(Duration = 300)] // Cache for 5 minutes
public async Task<IActionResult> GetAllProducts()
{
    // Implementation
}
```

### 3. Async/Await Best Practices
- Always use async/await for database operations
- Use ConfigureAwait(false) in libraries
- Avoid mixing sync and async code

### 4. Memory Management
```csharp
// Dispose DbContext properly (already handled by DI)
// Use streaming for large file uploads
// Implement pagination for large datasets

public async Task<PagedResult<ProductDto>> GetProductsPaginatedAsync(int page, int pageSize)
{
    var totalCount = await _productRepository.CountAsync();
    var products = await _productRepository.GetPagedAsync(page, pageSize);
    
    return new PagedResult<ProductDto>
    {
        Items = _mapper.Map<IEnumerable<ProductDto>>(products),
        TotalCount = totalCount,
        Page = page,
        PageSize = pageSize
    };
}
```

## 🧪 Testing Strategy

### 1. Unit Testing Setup
```bash
# Add test projects
dotnet new xunit -n PosterApp.Tests
dotnet add PosterApp.Tests package Microsoft.EntityFrameworkCore.InMemory
dotnet add PosterApp.Tests package Moq
dotnet add PosterApp.Tests package AutoMapper
dotnet sln add PosterApp.Tests/PosterApp.Tests.csproj
```

### 2. Sample Unit Test
```csharp
public class ProductServiceTests
{
    private readonly Mock<IProductRepository> _mockRepository;
    private readonly IMapper _mapper;
    private readonly ProductService _service;

    public ProductServiceTests()
    {
        _mockRepository = new Mock<IProductRepository>();
        var config = new MapperConfiguration(cfg => cfg.AddProfile<MappingProfile>());
        _mapper = config.CreateMapper();
        _service = new ProductService(_mockRepository.Object, _mapper);
    }

    [Fact]
    public async Task GetAllProductsAsync_ReturnsAllActiveProducts()
    {
        // Arrange
        var products = new List<Product>
        {
            new() { Name = "Test Product", Price = 10.00m, IsActive = true }
        };
        _mockRepository.Setup(x => x.GetActiveProductsAsync()).ReturnsAsync(products);

        // Act
        var result = await _service.GetAllProductsAsync();

        // Assert
        Assert.Single(result);
        Assert.Equal("Test Product", result.First().Name);
    }
}
```

### 3. Integration Testing
```csharp
public class ProductsControllerIntegrationTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;
    private readonly HttpClient _client;

    public ProductsControllerIntegrationTests(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task GetProducts_ReturnsSuccessStatusCode()
    {
        // Act
        var response = await _client.GetAsync("/api/products");

        // Assert
        response.EnsureSuccessStatusCode();
    }
}
```

## 📚 API Documentation

### Swagger Configuration
The API includes comprehensive Swagger documentation available at `/swagger` when running in development mode.

### API Endpoints Summary

#### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login

#### Products
- `GET /api/products` - Get all products
- `GET /api/products/{id}` - Get product by ID
- `POST /api/products` - Create product (Admin)
- `PUT /api/products/{id}` - Update product (Admin)
- `DELETE /api/products/{id}` - Delete product (Admin)

#### Custom Posters
- `POST /api/customposters` - Create custom poster
- `GET /api/customposters` - Get user's custom posters
- `GET /api/customposters/{id}` - Get custom poster by ID
- `POST /api/customposters/calculate-price` - Calculate poster price

#### Orders
- `POST /api/orders` - Create new order
- `GET /api/orders` - Get user's orders
- `GET /api/orders/{id}` - Get order by ID
- `GET /api/orders/admin/all` - Get all orders (Admin)
- `PUT /api/orders/{id}/status` - Update order status (Admin)

#### Health
- `GET /api/health` - Basic health check
- `GET /api/health/database` - Database health check

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow
```yaml
# .github/workflows/dotnet.yml
name: .NET Core CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
      with:
        dotnet-version: 8.0.x
        
    - name: Restore dependencies
      run: dotnet restore
      
    - name: Build
      run: dotnet build --no-restore
      
    - name: Test
      run: dotnet test --no-build --verbosity normal
      
    - name: Publish
      run: dotnet publish -c Release -o ./publish
      
    - name: Deploy to Azure
      if: github.ref == 'refs/heads/main'
      uses: azure/webapps-deploy@v2
      with:
        app-name: 'poster-app-api'
        publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
        package: './publish'
```

### Azure DevOps Pipeline
```yaml
# azure-pipelines.yml
trigger:
- main

pool:
  vmImage: 'ubuntu-latest'

variables:
  buildConfiguration: 'Release'

steps:
- task: UseDotNet@2
  inputs:
    packageType: 'sdk'
    version: '8.0.x'

- task: DotNetCoreCLI@2
  displayName: 'Restore packages'
  inputs:
    command: 'restore'
    projects: '**/*.csproj'

- task: DotNetCoreCLI@2
  displayName: 'Build project'
  inputs:
    command: 'build'
    projects: '**/*.csproj'
    arguments: '--configuration $(buildConfiguration)'

- task: DotNetCoreCLI@2
  displayName: 'Run tests'
  inputs:
    command: 'test'
    projects: '**/*Tests.csproj'
    arguments: '--configuration $(buildConfiguration)'

- task: DotNetCoreCLI@2
  displayName: 'Publish application'
  inputs:
    command: 'publish'
    publishWebProjects: true
    arguments: '--configuration $(buildConfiguration) --output $(build.artifactstagingdirectory)'

- task: PublishBuildArtifacts@1
  displayName: 'Publish artifacts'
```

## 🔒 Security Best Practices Checklist

- ✅ Input validation on all endpoints
- ✅ JWT token authentication
- ✅ Password hashing with BCrypt
- ✅ HTTPS enforcement
- ✅ CORS configuration
- ✅ SQL injection prevention (Entity Framework)
- ✅ XSS protection headers
- ✅ Rate limiting (recommended)
- ✅ Error handling without information disclosure
- ✅ Secure connection strings
- ⚠️ Consider implementing refresh tokens
- ⚠️ Add API versioning
- ⚠️ Implement audit logging
- ⚠️ Add request/response encryption for sensitive data

## 📋 Production Checklist

### Before Deployment
- [ ] Update connection strings
- [ ] Configure JWT secrets
- [ ] Set up SSL certificates
- [ ] Configure logging
- [ ] Set up monitoring
- [ ] Run security scan
- [ ] Performance testing
- [ ] Database backup strategy
- [ ] Error tracking (Application Insights/Sentry)

### Post Deployment
- [ ] Verify health endpoints
- [ ] Test authentication flow
- [ ] Monitor application logs
- [ ] Set up alerts
- [ ] Document API endpoints
- [ ] Train support team

## 🎯 Future Enhancements

### Recommended Features
1. **File Upload Service** - For custom poster images
2. **Payment Integration** - Stripe/PayPal integration
3. **Email Notifications** - Order confirmations, shipping updates
4. **Admin Dashboard** - Full-featured React/Vue admin panel
5. **Inventory Management** - Stock tracking for products
6. **Reviews & Ratings** - Customer feedback system
7. **Wishlist** - Save favorite products
8. **Discount Codes** - Promotional system
9. **Multi-language Support** - Internationalization
10. **Mobile App API** - Extend for mobile applications

### Scaling Considerations
- **Database Optimization** - Read replicas, indexing
- **Caching Strategy** - Redis for distributed caching
- **CDN Integration** - For image delivery
- **Microservices** - Split into smaller services
- **Message Queues** - For order processing
- **Load Balancing** - Multiple API instances

## 📞 Support

For questions and support:
- Check the GitHub issues
- Review the API documentation at `/swagger`
- Monitor application logs
- Use the health check endpoints for diagnostics

---

**Happy Coding! 🚀**
