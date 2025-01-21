class AmazonProduct {
  final String asin;
  final String thumbnail;
  final String title;
  final String price;

  AmazonProduct({
    required this.asin,
    required this.thumbnail,
    required this.title,
    required this.price,
  });

  factory AmazonProduct.fromJson(Map<String, dynamic> json) {
    return AmazonProduct(
      asin: json['asin'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      price: json['price'],
    );
  }
}
