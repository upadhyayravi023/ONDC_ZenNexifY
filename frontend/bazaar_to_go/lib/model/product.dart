// Class to represent an attribute or specification
class Attribute {
  String name;
  String value;

  Attribute({required this.name, required this.value});

  // Convert an Attribute instance to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }

  // Create an Attribute instance from a Map (JSON)
  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      name: json['name'],
      value: json['value'],
    );
  }
}

class Product {
  String productId;
  String title;
  double rating;
  double price;
  String description;
  String category;
  List<Attribute> attributes;
  List<Attribute> specifications;
  List<String> images;

  Product({
    required this.productId,
    required this.title,
    required this.rating,
    required this.price,
    required this.description,
    required this.category,
    this.attributes = const [],
    this.specifications = const [],
    this.images = const [],
  });

  // Convert a Product instance to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'title': title,
      'rating': rating,
      'price': price,
      'description': description,
      'category': category,
      'attributes': attributes.map((attr) => attr.toJson()).toList(),
      'specifications': specifications.map((spec) => spec.toJson()).toList(),
      'images': images,
    };
  }

  // Create a Product instance from a Map (JSON)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['asin'] ?? '', // Use 'asin' as productId
      title: json['title'] ?? 'No Title',
      rating: (json['rating'] != null) ? json['rating'].toDouble() : 0.0,
      price: (json['buybox']['price']['value'] != null) ? json['buybox']['price']['value'].toDouble() : 0.0,
      description: json['description'] ?? "Not available",
      category: json['categories'] != null && json['categories'].isNotEmpty
          ? json['categories'][0]['title'] // Get the first category title
          : "unknown",
      attributes: (json['attributes'] as List<dynamic>? ?? [])
          .map((attr) => Attribute.fromJson(attr as Map<String, dynamic>))
          .toList(),
      specifications: (json['specifications'] as List<dynamic>? ?? [])
          .map((spec) => Attribute.fromJson(spec as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>? ?? [])
          .map((img) => img['link'] as String)
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Product ID: $productId\n'
        'Title: $title\n'
        'Rating: $rating\n'
        'Price: $price\n'
        'Description: $description\n'
        'Category: $category\n'
        'Attributes: ${attributes.map((attr) => '${attr.name}: ${attr.value}').join(', ')}\n'
        'Specifications: ${specifications.map((spec) => '${spec.name}: ${spec.value}').join(', ')}\n'
        'Images: $images\n';
  }
}
