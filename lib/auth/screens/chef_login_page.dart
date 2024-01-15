import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/auth/bloc/authentication_cubit.dart';
import 'package:hotel_kitchen_management_flutter/chef_view/screens/chef_list_view.dart';

class ChefLoginPage extends StatefulWidget {
  const ChefLoginPage({Key? key}) : super(key: key);

  @override
  State<ChefLoginPage> createState() => _ChefLoginPageState();
}

class _ChefLoginPageState extends State<ChefLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chef_user'.tr),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(
              controller: emailController,
              labelText: 'email'.tr,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            _buildTextField(
              controller: passwordController,
              labelText: 'password'.tr,
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => _login(),
              child: Text('login'.tr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  void _login() {
    // Validate fields before attempting login
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('email_pass_error'.tr),
        ),
      );
    } else {
      AuthenticationCubit().signUpUser(
        context,
        emailController.text,
        passwordController.text,
        'chef',
        () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ChefOrderManagementScreen(),
            ),
            (route) => false,
          );
        },
      );
      // Trigger the login event
      // context.read<AuthenticationBloc>().add(AuthenticationEvent.login);
    }
  }
}
