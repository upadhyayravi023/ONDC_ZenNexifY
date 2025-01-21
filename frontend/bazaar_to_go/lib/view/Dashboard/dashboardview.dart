import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaar_to_go/view/Dashboard/chat_bot.dart';
import 'package:intl/intl.dart';
import '../../widgets/barchat.dart';
import '../../widgets/charts.dart';

class Dashboardview extends StatefulWidget {
  final String username;
  Dashboardview({super.key, required this.username});

  @override
  State<Dashboardview> createState() => _DashboardviewState();
}

class _DashboardviewState extends State<Dashboardview> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 5,
        leading: Icon(Icons.menu, color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('d MMM y').format(DateTime.now()),
              style: TextStyle(color: Colors.black54, fontSize: screenWidth * 0.05),
            ),
            Text(
              "Welcome ${widget.username}!",
              style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.06),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            // backgroundImage: AssetImage('assets/profile.jpg'), // Replace with a network image or asset
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStoreButton(context, 'Store 1'),
                      _buildStoreButton(context, 'Store 2'),
                      _buildStoreButton(context, 'Store 3'),
                    ],
                  ),
                ),
              ),
              Text(
                'Reports',
                style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ReportCard(
                      title: 'Total Balance',
                      value: '\$ 12,000',
                      icon: Icons.account_balance_wallet,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ReportCard(
                      title: 'Total Expenses',
                      value: '\$ 4,000',
                      icon: Icons.money_off,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ReportCard(
                      title: 'Total Income',
                      value: '\$ 16,000',
                      icon: Icons.attach_money,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ReportCard(
                      title: 'Total Savings',
                      value: '\$ 8,000',
                      icon: Icons.savings,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(thickness: 3, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Product Distribution Status',
                style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              UserCard(),
              SizedBox(height: 24),
              UserCard2(),
            ],
          ),
        ),
      ),
      floatingActionButton: Tooltip(
        message: 'Ask AI',
        verticalOffset: 30,
        preferBelow: false,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: Colors.white, // Tooltip text color
          fontWeight: FontWeight.bold,
          fontSize: 14, // Tooltip font size
        ),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(ChatPage());
          },
          child: Icon(Icons.chat),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  ElevatedButton _buildStoreButton(BuildContext context, String label) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 12), // Responsive padding
        side: BorderSide(color: Colors.blue, width: 1),
      ),
      child: Tooltip(
        message: 'Go to $label', // Tooltip for each button
        decoration: BoxDecoration(
          color: Colors.black, // Tooltip background color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        textStyle: TextStyle(
          color: Colors.white, // Tooltip text color
          fontWeight: FontWeight.bold,
          fontSize: 14, // Tooltip font size
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}



class ReportCard extends StatefulWidget {
  final String title;
  final String value;
  final String? change;
  final IconData icon;
  final Color color;

  const ReportCard({
    required this.title,
    required this.value,
    this.change,
    required this.icon,
    required this.color,
  });

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // Animation for opacity (fade-in effect)
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Animation for slide in from the bottom
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Animation for scale effect
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when widget is built
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: SlideTransition(
            position: _slideAnimation,
            child: Opacity(
              opacity: _opacity.value,
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(widget.icon, color: widget.color, size: 32),
                      SizedBox(height: 8),
                      Text(
                        widget.title,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.value,
                        style: TextStyle(fontSize: 16),
                      ),
                      if (widget.change != null) ...[
                        SizedBox(height: 8),
                        Text(
                          widget.change!,
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.8),
            spreadRadius: 0.5,
            blurRadius: 6,
          ),
        ],
      ),
      height: screenWidth * 0.5, // Responsive height based on screen width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChartExample(), // Replace with your widget
            ),
          ),
        ],
      ),
    );
  }
}


class UserCard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.8),
            spreadRadius: 0.5,
            blurRadius: 6,
          ),
        ],
      ),
      height: screenWidth * 0.5, // Responsive height based on screen width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomBarChartWidget(), // Replace with your widget
            ),
          ),
        ],
      ),
    );
  }
}
