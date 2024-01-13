import 'package:flutter/material.dart';
import 'package:hotel_kitchen_management_flutter/auth/screens/admin_login_page.dart';
import 'package:hotel_kitchen_management_flutter/auth/screens/chef_login_page.dart';

class ChooseAuthOptionsPage extends StatelessWidget {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminLoginPage()));
              },
              child: Text('Admin Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChefLoginPage()));
              },
              child: Text('Chef Login'),
            ),
          ],
        ),
      ),
    );
  }
}
