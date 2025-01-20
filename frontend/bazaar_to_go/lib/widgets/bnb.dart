import 'package:bazaar_to_go/view/order/order.dart';
import 'package:bazaar_to_go/view/store/register_shop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_to_go/view/order/order.dart';
import '../controllers/bnb_controller.dart';
import '../view/Dashboard/dashboardview.dart';
import '../view/order/ordersum.dart';
import '../view/profile/profile.dart';

class bnb extends StatelessWidget {

  final String username;
  final BottomNavController bottomNavController = Get.put(BottomNavController());
  bnb({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Dashboardview(username: username,),
      RegisterShop(username: username,),
      OrdersSummary(),
      ProfileView(username : username),
    ];

    return Scaffold(
      body: Obx(() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[bottomNavController.selectedIndex.value],
      )),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: (index) => bottomNavController.changeIndex(index),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home, bottomNavController.selectedIndex.value == 0),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.store, bottomNavController.selectedIndex.value == 1),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.shopping_cart, bottomNavController.selectedIndex.value == 2),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.person, bottomNavController.selectedIndex.value == 3),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }

  // Custom method for animated icons
  Widget _buildIcon(IconData icon, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSelected ? 30 : 24,
      height: isSelected ? 30 : 24,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: isSelected ? Colors.blueAccent : Colors.grey[600]),
    );
  }
}
