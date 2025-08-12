using AutoMapper;
using PosterApp.Core.DTOs;
using PosterApp.Core.Entities;
using PosterApp.Core.Interfaces;

namespace PosterApp.Core.Services;

public class ProductService : IProductService
{
    private readonly IProductRepository _productRepository;
    private readonly IMapper _mapper;

    public ProductService(IProductRepository productRepository, IMapper mapper)
    {
        _productRepository = productRepository;
        _mapper = mapper;
    }

    public async Task<IEnumerable<ProductDto>> GetAllProductsAsync()
    {
        var products = await _productRepository.GetActiveProductsAsync();
        return _mapper.Map<IEnumerable<ProductDto>>(products);
    }

    public async Task<ProductDto?> GetProductByIdAsync(Guid id)
    {
        var product = await _productRepository.GetByIdAsync(id);
        return product != null ? _mapper.Map<ProductDto>(product) : null;
    }

    public async Task<ProductDto> CreateProductAsync(CreateProductDto request)
    {
        var product = _mapper.Map<Product>(request);
        await _productRepository.AddAsync(product);
        return _mapper.Map<ProductDto>(product);
    }

    public async Task<ProductDto> UpdateProductAsync(Guid id, CreateProductDto request)
    {
        var product = await _productRepository.GetByIdAsync(id);
        if (product == null)
            throw new KeyNotFoundException("Product not found");

        _mapper.Map(request, product);
        product.UpdatedAt = DateTime.UtcNow;
        await _productRepository.UpdateAsync(product);
        
        return _mapper.Map<ProductDto>(product);
    }

    public async Task DeleteProductAsync(Guid id)
    {
        var product = await _productRepository.GetByIdAsync(id);
        if (product == null)
            throw new KeyNotFoundException("Product not found");

        await _productRepository.DeleteAsync(product);
    }
}
