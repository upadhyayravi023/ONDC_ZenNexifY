import 'package:bazaar_to_go/model/amazon_product.dart';
import 'package:bazaar_to_go/model/product.dart';
import 'package:get/get.dart';

class UploadProductController extends GetxController {
  final RxList<AmazonProduct> products = <AmazonProduct>[].obs;
  RxBool isLoading = false.obs;

  void changeLoading() {
    isLoading.value = !isLoading.value;
  }

  final templates = [
    Product(
      productId: "P001",
      title: "Samsung 4K Smart TV",
      rating: 4.5,
      price: 899.99,
      description:
          "Experience stunning 4K visuals and smart features on this Samsung Smart TV.",
      attributes: [
        Attribute(name: "Screen Size", value: "55 inches"),
        Attribute(name: "Display Type", value: "LED"),
        Attribute(name: "HDR Support", value: "HDR10+"),
      ],
      specifications: [
        Attribute(name: "Refresh Rate", value: "120Hz"),
        Attribute(name: "Smart OS", value: "Tizen"),
        Attribute(name: "Connectivity", value: "Wi-Fi, Bluetooth, HDMI"),
      ],
      images: ["https://m.media-amazon.com/images/I/71RxCmvnrbL._SX679_.jpg"],
      category: "Electronics",
    ),
    Product(
      productId: "P002",
      title: "iPhone 14 Pro",
      rating: 4.8,
      price: 999.00,
      description:
          "The latest iPhone with a powerful A-series chip and a pro-level camera system.",
      attributes: [
        Attribute(name: "Storage", value: "256GB"),
        Attribute(name: "Color", value: "Space Black"),
        Attribute(name: "Connectivity", value: "5G"),
      ],
      specifications: [
        Attribute(name: "Display", value: "Super Retina XDR"),
        Attribute(name: "Camera", value: "Triple Camera System"),
        Attribute(name: "Battery Life", value: "Up to 24 hours"),
      ],
      images: [
        "https://m.media-amazon.com/images/I/61giwQtR1qL._AC_UY218_.jpg"
      ],
      category: "Electronics",
    ),
    Product(
      productId: "P003",
      title: "Sony WH-1000XM5 Headphones",
      rating: 4.7,
      price: 399.00,
      description:
          "Industry-leading noise cancellation for immersive listening experiences.",
      attributes: [
        Attribute(name: "Color", value: "Black"),
        Attribute(name: "Style", value: "Over-Ear"),
        Attribute(name: "Connectivity", value: "Bluetooth"),
      ],
      specifications: [
        Attribute(name: "Battery Life", value: "30 hours"),
        Attribute(name: "Audio Codec", value: "LDAC"),
        Attribute(
            name: "Microphone", value: "Dual Noise-Canceling Microphones"),
      ],
      images: [
        "https://m.media-amazon.com/images/I/51rpbVmi9XL._AC_SX148_SY213_FMwebp_QL65_.jpg"
      ],
      category: "Electronics",
    ),
    Product(
      productId: "P004",
      title: "Philips Foodi 7-in-1 Air Fryer",
      rating: 4.6,
      price: 199.00,
      description:
          "Versatile kitchen appliance for air frying, baking, roasting, and more.",
      attributes: [
        Attribute(name: "Capacity", value: "4 Quart"),
        Attribute(name: "Color", value: "Black"),
        Attribute(name: "Features", value: "7-in-1 Functionality"),
      ],
      specifications: [
        Attribute(name: "Temperature Range", value: "105°F - 450°F"),
        Attribute(name: "Timer", value: "60 Minute Timer"),
        Attribute(name: "Dishwasher Safe Parts", value: "Yes"),
      ],
      images: [
        "https://m.media-amazon.com/images/I/41ZZkBMZbIL._AC_SX148_SY213_FMwebp_QL65_.jpg"
      ],
      category: "Home Appliances",
    ),
    Product(
      productId: "P007",
      title: "Nike Air Max 90",
      rating: 4.7,
      price: 129.99,
      description:
          "Iconic running shoes with a comfortable and stylish design.",
      attributes: [
        Attribute(name: "Color", value: "White/Black"),
        Attribute(name: "Size", value: "Men's 10"),
        Attribute(name: "Style", value: "Running Shoes"),
      ],
      specifications: [
        Attribute(name: "Material", value: "Leather, Mesh"),
        Attribute(name: "Cushioning", value: "Air Max Unit"),
        Attribute(name: "Closure", value: "Lace-Up"),
      ],
      images: [
        "https://m.media-amazon.com/images/I/71D-9au0J1L._AC_SR175,263_FMwebp_QL65_.jpg"
      ],
      category: "Footwear",
    ),
    Product(
      productId: "P008",
      title: "Ray-Ban Aviator Sunglasses",
      rating: 4.6,
      price: 150.00,
      description: "Classic and timeless sunglasses with a timeless design.",
      attributes: [
        Attribute(name: "Frame Material", value: "Metal"),
        Attribute(name: "Lens Color", value: "Green"),
        Attribute(name: "Style", value: "Aviator"),
      ],
      specifications: [
        Attribute(name: "UV Protection", value: "100% UVA/UVB"),
        Attribute(name: "Frame Color", value: "Gold"),
        Attribute(name: "Lens Material", value: "Glass"),
      ],
      images: [
        "https://m.media-amazon.com/images/I/517gYBwT-YL._AC_SR175,263_FMwebp_QL65_.jpg"
      ],
      category: "Accessories",
    ),
    Product(
      productId: "P009",
      title: "Levi's 501 Original Fit Jeans",
      rating: 4.5,
      price: 59.99,
      description: "Classic straight leg jeans with a timeless style.",
      attributes: [
        Attribute(name: "Color", value: "Blue"),
        Attribute(name: "Size", value: "32W x 32L"),
        Attribute(name: "Material", value: "100% Cotton"),
      ],
      specifications: [
        Attribute(name: "Fit", value: "Original Fit"),
        Attribute(name: "Closure", value: "Button Fly"),
        Attribute(name: "Care", value: "Machine Washable"),
      ],
      images: [
        "https://m.media-amazon.com/images/I/5126264vf4L._AC_SR175,263_FMwebp_QL65_.jpg"
      ],
      category: "Clothing",
    ),
  ];
}
