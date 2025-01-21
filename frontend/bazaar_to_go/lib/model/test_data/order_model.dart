class Order {
  final String orderId;
  final String productId;
  final String productName;
  final String customerName;
  final String phoneNumber;
  final String deliveryAddress;
  bool fulfilled;

  Order({
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.customerName,
    required this.phoneNumber,
    required this.deliveryAddress,
    this.fulfilled = false,
  });

  // Toggle fulfillment status
  void toggleFulfillment() {
    fulfilled = !fulfilled;
  }
}
