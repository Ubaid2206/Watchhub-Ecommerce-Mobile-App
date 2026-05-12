class WatchModel {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String description;
  final List<String> images;
  final String category;
  final int stock;
  final double rating;
  final int reviewCount;
  final Map<String, String> specifications;

  WatchModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    required this.specifications,
  });

  factory WatchModel.fromJson(Map<String, dynamic> json) {
    return WatchModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      stock: json['stock'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      specifications: Map<String, String>.from(json['specifications'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'description': description,
      'images': images,
      'category': category,
      'stock': stock,
      'rating': rating,
      'reviewCount': reviewCount,
      'specifications': specifications,
    };
  }
}