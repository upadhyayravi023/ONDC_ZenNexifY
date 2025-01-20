import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/api_service.dart';
import '../../repository/endpoint.dart';
import '../../widgets/profile.dart';
import '../auth/login_screen.dart';
import 'accounts.dart';
import 'help.dart';


class ProfileView extends StatefulWidget {
  final String username;

  ProfileView({Key? key, required this.username}) : super(key: key);

  @override

  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {


  @override
  void initState() {
    super.initState();

  }
  Future<void> _onLogout() async {
    try {
      final response = await ApiService.post(
        Endpoint.logout.getUrl(),
        {
          'username': widget.username,
        } as Map<String, dynamic>,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Logout Successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAll(LoginScreen());
      } else {
        print("Logout Failed: ${response.statusCode}, ${response.body}");
        Get.snackbar(
          'Error',
          'Logout Failed: ${response.body}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      printError(info: error.toString());

      Get.snackbar(
        'Error',
        'Logout failed. Please try again. \n$error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
        shadowColor: Colors.blue,
        elevation: 3,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
            children: [
             _buildPortraitLayout(context, widget.username),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _onLogout(),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // No rounded corners, makes it a rectangle
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPortraitLayout(BuildContext context, String username) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 5),
              ),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.15,
               // backgroundImage: NetworkImage(userData.avatarlink),
               // onBackgroundImage: (_, __) => Icon(Icons.person, size: MediaQuery.of(context).size.width * 0.10),
              ),
            ),
            SizedBox(height: 10),
            Text("name",
             // userData.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
      ),

      //Personal Information Section
      Row(
        children: [
          Text('Personal Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Spacer(),
          IconButton(
            icon: Icon(Icons.edit),
          //  onPressed: () => Get.to(() => EditProfilePage()),
            onPressed: null,
          ),
          Text('Edit'),
        ],
      ),
      ProfileInfoTile(
        title: 'Email',
        value: "",
        leading: Icon(Icons.email),
      ),
      SizedBox(height: 10),
      ProfileInfoTile(
        title: 'Phone',
        value: '',
        leading: Icon(Icons.phone_android),
      ),
      SizedBox(height: 10),
      ProfileInfoTile(
        title: 'Stores',
        value: '',
        leading: Icon(Icons.phone_android),
      ),
      SizedBox(height: 10),
      ProfileInfoTile(
        title: 'Products',
        value: '',
        leading: Icon(Icons.phone_android),
      ),
      SizedBox(height: 10),
      ProfileInfoTile(
        title: 'Address',
        value: '',
        leading: Icon(Icons.phone_android),
      ),
      SizedBox(height: 10),
     

      // Utilities Section
      Text('Utilities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ProfileInfoTile(
        title: 'Account Settings',
        value: '',
        leading: Icon(Icons.perm_identity),
      onPressed: () => Get.to(() => AccountSettings(username: username)),
      ),
      SizedBox(height: 10),
      ProfileInfoTile(
        title: 'Help Desk',
        value: '',
        leading: Icon(Icons.question_mark),
        onPressed: () => Get.to(() => HelpDesk()),

      ),
      SizedBox(height: 10),

    ],
  );
}




