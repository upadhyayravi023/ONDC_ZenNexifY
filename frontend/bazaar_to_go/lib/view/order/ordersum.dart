import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_to_go/controllers/order_controller.dart';

class OrdersSummary extends StatefulWidget {
  @override
  _OrdersSummaryState createState() => _OrdersSummaryState();
}

class _OrdersSummaryState extends State<OrdersSummary> with SingleTickerProviderStateMixin {
  final OrderController controller = Get.put(OrderController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // Ensure that the widget is mounted before initializing
    if (mounted) {
      _tabController = TabController(length: 3, vsync: this);
    }
  }

  @override
  void dispose() {
    // Make sure to dispose the TabController when the widget is disposed
    if (mounted) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure the TabController is initialized


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders Summary',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        leading: const Icon(Icons.menu, color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            width: double.infinity,
            child: TabBar(
              controller: _tabController, // Use initialized TabController
              indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: const [
                Tab(text: '   Shop 1   '),
                Tab(text: '   Shop 2   '),
                Tab(text: '   Shop 3   '),
              ],
            ),
          ),
        ),
      ),
      body: GetX<OrderController>(
        builder: (controller) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildShopContent(controller, 'Shop 1'),
              _buildShopContent(controller, 'Shop 2'),
              _buildShopContent(controller, 'Shop 3'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildShopContent(OrderController controller, String shopName) {
    final fulfilledOrders = controller.orders
        .where((order) => order.fulfilled == true)
        .toList();
    final unfulfilledOrders = controller.orders
        .where((order) => order.fulfilled == false)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fulfilled',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildOrdersTable(fulfilledOrders, controller),
          const SizedBox(height: 24),
          const Text(
            'Not Fulfilled',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildOrdersTable(unfulfilledOrders, controller),
        ],
      ),
    );
  }

  Widget _buildOrdersTable(
      List<Order> orders, OrderController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Horizontal scroll
      child: DataTable(
        columns: [
          DataColumn(label: Text('Order Id')),
          DataColumn(label: Text('Product Id')),
          DataColumn(label: Text('Product Name')),
          DataColumn(label: Text('Customer Name')),
          DataColumn(label: Text('Phone Number')),
          DataColumn(label: Text('Dilivery Address')),
          DataColumn(label: Text('Fulfillment')),
        ],
        rows: orders.map((order) {
          return DataRow(
            cells: [
              DataCell(Text(order.orderId)),
              DataCell(Text(order.productId)),
              DataCell(Text(order.productName)),
              DataCell(Text(order.customerName)),
              DataCell(Text(order.phoneNumber)),
              DataCell(Text(order.deliveryAddress)),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    controller.toggleOrderFulfillment(order.orderId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: order.fulfilled
                        ? Colors.green
                        : Colors.red,
                  ),
                  child: Text(order.fulfilled ? 'Fulfilled' : 'Unfulfilled'),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
