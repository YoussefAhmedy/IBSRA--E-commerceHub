CREATE DATABASE PosterAppDB;
GO

USE PosterAppDB;
GO

-- Users Table
CREATE TABLE Users (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(500) NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE()
);

-- Products Table (Pre-made posters)
CREATE TABLE Products (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500),
    ImageUrl NVARCHAR(500),
    Category NVARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    Size NVARCHAR(50), -- e.g., "30cm x 40cm"
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE()
);

-- Custom Posters Table
CREATE TABLE CustomPosters (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    UserId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Users(Id),
    ImageUrl NVARCHAR(500) NOT NULL,
    Size NVARCHAR(50) NOT NULL,
    FrameType NVARCHAR(50), -- Black, Red, Natural, Dark, None
    FramePrice DECIMAL(10,2) DEFAULT 0,
    BasePrice DECIMAL(10,2) NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE()
);

-- Orders Table
CREATE TABLE Orders (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    OrderNumber NVARCHAR(50) UNIQUE NOT NULL,
    UserId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Users(Id),
    Status NVARCHAR(50) DEFAULT 'Pending', -- Pending, Processing, Shipped, Delivered, Cancelled
    TotalAmount DECIMAL(10,2) NOT NULL,
    ShippingCost DECIMAL(10,2) DEFAULT 0,
    ShippingAddress NVARCHAR(500) NOT NULL,
    ShippingCity NVARCHAR(100) NOT NULL,
    ShippingZipCode NVARCHAR(20) NOT NULL,
    Phone NVARCHAR(20),
    DeliveryType NVARCHAR(50), -- Standard, Express
    EstimatedDeliveryStart DATE,
    EstimatedDeliveryEnd DATE,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE()
);

-- Order Items Table
CREATE TABLE OrderItems (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    OrderId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Orders(Id),
    ProductId UNIQUEIDENTIFIER NULL FOREIGN KEY REFERENCES Products(Id),
    CustomPosterId UNIQUEIDENTIFIER NULL FOREIGN KEY REFERENCES CustomPosters(Id),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,
    ItemType NVARCHAR(20) -- 'Product' or 'Custom'
);

-- Insert sample data
INSERT INTO Products (Name, Description, ImageUrl, Category, Price, Size) VALUES
('Abstract Geometric Art', 'Modern abstract geometric artwork perfect for contemporary spaces.', 'https://example.com/abstract1.jpg', 'Abstract', 24.99, '30cm x 40cm'),
('Nature Landscape', 'Beautiful nature landscape poster', 'https://example.com/nature1.jpg', 'Nature', 29.99, '40cm x 50cm');

-- Categories Table
CREATE TABLE Categories (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(500),
    ImageUrl NVARCHAR(500), -- Category thumbnail/banner image
    DisplayOrder INT DEFAULT 0, -- For ordering categories in UI
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE()
);

-- Update Products Table to reference Categories
-- First, add the new CategoryId column
ALTER TABLE Products 
ADD CategoryId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Categories(Id);

-- Insert sample categories
INSERT INTO Categories (Name, Description, ImageUrl, DisplayOrder) VALUES
('Abstract', 'Modern abstract and geometric artwork', 'https://example.com/categories/abstract.jpg', 1),
('Nature & Landscapes', 'Beautiful nature scenes and landscapes', 'https://example.com/categories/nature.jpg', 2),
('Minimalist', 'Clean, simple, and minimalist designs', 'https://example.com/categories/minimalist.jpg', 3),
('Vintage & Retro', 'Classic vintage and retro-style posters', 'https://example.com/categories/vintage.jpg', 4),
('Photography', 'Stunning photographic prints', 'https://example.com/categories/photography.jpg', 5),
('Typography', 'Text-based and typography art', 'https://example.com/categories/typography.jpg', 6),
('Animals', 'Wildlife and pet photography', 'https://example.com/categories/animals.jpg', 7),
('Cities & Architecture', 'Urban landscapes and architectural photography', 'https://example.com/categories/cities.jpg', 8),
('Botanical', 'Plants, flowers, and botanical illustrations', 'https://example.com/categories/botanical.jpg', 9),
('Sports & Fitness', 'Sports photography and motivational fitness posters', 'https://example.com/categories/sports.jpg', 10),
('Movies & TV', 'Entertainment and pop culture posters', 'https://example.com/categories/movies.jpg', 11),
('Music', 'Music-related artwork and band posters', 'https://example.com/categories/music.jpg', 12);

-- Update existing products to link to categories
UPDATE Products 
SET CategoryId = (SELECT Id FROM Categories WHERE Name = 'Abstract')
WHERE Category = 'Abstract';

UPDATE Products 
SET CategoryId = (SELECT Id FROM Categories WHERE Name = 'Nature & Landscapes')
WHERE Category = 'Nature';

-- Add categories for custom posters as well
ALTER TABLE CustomPosters 
ADD CategoryId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Categories(Id);
