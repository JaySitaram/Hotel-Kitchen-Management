import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/auth/screens/admin_login_page.dart';
import 'package:hotel_kitchen_management_flutter/auth/screens/chef_login_page.dart';
import 'package:hotel_kitchen_management_flutter/chef_view/screens/chef_list_view.dart';
import 'package:hotel_kitchen_management_flutter/const/storage.dart';
import 'package:hotel_kitchen_management_flutter/dashboard/screens/dashboard_view.dart';

class ChooseAuthOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _checkLoggedInUser();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('user_role'.tr),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _navigateToLoginPage(AdminLoginPage()),
              child: Text('admin'.tr),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToLoginPage(ChefLoginPage()),
              child: Text('chef'.tr),
            ),
          ],
        ),
      ),
    );
  }

  void _checkLoggedInUser() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final email = LocalStorage.readStorage(LocalStorage.email);
      final userRole = LocalStorage.readStorage(LocalStorage.userRole);

      if (email != null && email.isNotEmpty) {
        if (userRole == 'admin') {
          Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
            builder: (context) => AdminDashboard(),
          ));
        } else {
          Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
            builder: (context) => ChefOrderManagementScreen(),
          ));
        }
      }
    });
  }

  void _navigateToLoginPage(Widget page) {
    Navigator.of(Get.context!)
        .push(MaterialPageRoute(builder: (context) => page));
  }
}
