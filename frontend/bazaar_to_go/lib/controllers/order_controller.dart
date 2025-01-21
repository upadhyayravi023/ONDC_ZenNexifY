import 'package:get/get.dart';
import 'package:bazaar_to_go/model/test_data/order_model.dart';


import 'package:get/get.dart';

class Order {
  String orderId;
  String productId;
  String productName;
  String customerName;
  String phoneNumber;
  String deliveryAddress;
  bool fulfilled;

  Order({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.customerName,
    required this.phoneNumber,
    required this.deliveryAddress,
    required this.fulfilled,
  });

  // Toggle fulfillment status
  void toggleFulfillment() {
    fulfilled = !fulfilled;
  }
}

class OrderController extends GetxController {
  // List of orders with multiple products per order
  var orders = <Order>[
    Order(
      orderId: '12345',
      productId: '99876',
      productName: 'Air Jordan Shoes',
      customerName: 'John Doe',
      phoneNumber: '9876543210',
      deliveryAddress: '123, Park Street, NY',
      fulfilled: true,
    ),
    Order(
      orderId: '12346',
      productId: '99877',
      productName: 'Women\'s Sweater',
      customerName: 'Jane Smith',
      phoneNumber: '9876543211',
      deliveryAddress: '456, Elm Avenue, LA',
      fulfilled: true,
    ),
    Order(
      orderId: '12347',
      productId: '99878',
      productName: 'Women\'s Skirt',
      customerName: 'Alice Johnson',
      phoneNumber: '9876543212',
      deliveryAddress: '789, Pine Road, TX',
      fulfilled: false,
    ),
    Order(
      orderId: '12348',
      productId: '99879',
      productName: 'Bata Shoes',
      customerName: 'Bob Brown',
      phoneNumber: '9876543213',
      deliveryAddress: '101, Maple Street, FL',
      fulfilled: false,
    ),
    Order(
      orderId: '12350',
      productId: '99881',
      productName: 'Full Winter Set',
      customerName: 'Charlie Green',
      phoneNumber: '9876543214',
      deliveryAddress: '202, Oak Lane, IL',
      fulfilled: false,
    ),
    // Additional orders added here
    Order(
      orderId: '12351',
      productId: '99882',
      productName: 'Leather Jacket',
      customerName: 'David Brown',
      phoneNumber: '9876543215',
      deliveryAddress: '303, Birch Road, TX',
      fulfilled: false,
    ),
    Order(
      orderId: '12352',
      productId: '99883',
      productName: 'Denim Jeans',
      customerName: 'Emily White',
      phoneNumber: '9876543216',
      deliveryAddress: '404, Cedar Avenue, NY',
      fulfilled: true,
    ),
    Order(
      orderId: '12353',
      productId: '99884',
      productName: 'Winter Boots',
      customerName: 'Frank Harris',
      phoneNumber: '9876543217',
      deliveryAddress: '505, Pine Drive, FL',
      fulfilled: false,
    ),
    Order(
      orderId: '12354',
      productId: '99885',
      productName: 'Smartphone',
      customerName: 'Grace Lee',
      phoneNumber: '9876543218',
      deliveryAddress: '606, Oak Lane, IL',
      fulfilled: true,
    ),
    Order(
      orderId: '12355',
      productId: '99886',
      productName: 'Fitness Tracker',
      customerName: 'Helen Clark',
      phoneNumber: '9876543219',
      deliveryAddress: '707, Maple Road, LA',
      fulfilled: true,
    ),
  ].obs;
  // Method to add a new product to an existing order
  void addProductToOrder(String orderId, String productId, String productName) {
    final order = orders.firstWhere((order) => order.orderId == orderId);
    order.productId = productId;
    order.productName = productName;
  }

  // Toggle fulfillment status of an order
  void toggleOrderFulfillment(String orderId) {
    final order = orders.firstWhere((order) => order.orderId == orderId);
    order.toggleFulfillment();
  }
}
